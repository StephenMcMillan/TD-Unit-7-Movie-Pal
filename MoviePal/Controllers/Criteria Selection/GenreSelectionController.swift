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
    
    var genreDataSource = GenreSelectionDataSource()
    
    lazy var genreSelectionDelegate: SelectionTableDelegate = {
        return SelectionTableDelegate(doneButton: nextBarButton, selectedItemsLabel: numberOfSelectedItemsLabel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = genreDataSource
        tableView.delegate = genreSelectionDelegate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectActors", let actorsSelectionController = segue.destination as? ActorSelectionController {
            // Moving to the actors view. Pass a reference to the delegate.
            if let selectedItems = tableView.indexPathsForSelectedRows {
                let genres = selectedItems.map { genreDataSource.genres[$0.row] }
                resultsDelegate?.genresSelected(genres)

                actorsSelectionController.resultsDelegate = resultsDelegate
                resultsDelegate = nil
            }
            
        }
    }
    
}
