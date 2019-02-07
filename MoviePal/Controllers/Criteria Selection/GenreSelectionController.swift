//
//  GenreSelectionController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class GenreSelectionController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfSelectedItemsLabel: UILabel!
    
    weak var resultsDelegate: ResultsDelegate?
    
    // Table View Data Source & Delegate
    
    lazy var genreDataSource = {
        return SelectionTableDataSource<Genre>(tableView: tableView)
    }()
    
    lazy var genreSelectionDelegate: SelectionTableDelegate = {
        return SelectionTableDelegate(doneButton: nextBarButton, selectedItemsLabel: numberOfSelectedItemsLabel)
    }()
    
    // Networking Client
    let movieDBClient = MovieDBClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = genreDataSource
        tableView.delegate = genreSelectionDelegate
    
        fetchGenres()
    }
    
    func fetchGenres() {
        
        // Download the genres from the movie db api and alert the data source.
        movieDBClient.getGenres { [weak self] result in
            switch result {
            case .success(let genres):
                self?.genreDataSource.update(with: genres)
                
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectActors", let actorsSelectionController = segue.destination as? ActorSelectionController {
            // Moving to the actors view. Pass a reference to the delegate.
            if let selectedItems = tableView.indexPathsForSelectedRows {
                let genres = selectedItems.map { genreDataSource.object(at: $0) }
                resultsDelegate?.genresSelected(genres)

                actorsSelectionController.resultsDelegate = resultsDelegate
                resultsDelegate = nil
            }
            
        }
    }
    
}
