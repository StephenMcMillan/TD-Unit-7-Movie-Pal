//
//  ActorSelectionController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class ActorSelectionController: UIViewController {

    // Interface Builder Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var numberOfSelectedActorsLabel: UILabel!
    @IBOutlet weak var headerPrompt: UILabel!
    @IBOutlet weak var networkIndicator: UIActivityIndicatorView!
    
    // Allows the view controller to communicate its results with the parent.
    weak var resultsDelegate: ResultsDelegate?
    
    let client = MovieDBClient()
    
    // Other Properties
    lazy var actorsDataSource = {
        return SelectionTableDataSource<Person>(tableView: tableView)
    }()
    
    lazy var actorsSelectionDelegate = {
        return SelectionTableDelegate(doneButton: nextBarButton, selectedItemsLabel: numberOfSelectedActorsLabel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = actorsDataSource
        tableView.delegate = actorsSelectionDelegate
        
        fetchActors()
    }
    
    func fetchActors() {
        
        client.getPopularActors { [weak self] result in
            switch result {
            case .success(let actors):
                self?.networkIndicator.stopAnimating()
                self?.headerPrompt.isHidden = false
                self?.actorsDataSource.update(with: actors)
            case .failure(let error):
                let alert = errorAlert(for: error, actionCompletion: {
                    self?.navigationController?.dismiss(animated: true, completion: nil)
                })
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRating", let minimumRatingController = segue.destination as? MinimumRatingSelectionController {
            
            if let selectedItems = tableView.indexPathsForSelectedRows {
                let actors = selectedItems.map { actorsDataSource.object(at: $0) }
                
                resultsDelegate?.actorsSelected(actors)
                
            }
            
            minimumRatingController.resultsDelegate = resultsDelegate
            
            
        }
    }
    
    
}

