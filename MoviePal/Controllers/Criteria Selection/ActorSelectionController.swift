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
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var numberOfSelectedActorsLabel: UILabel!
    
    // Allows the view controller to communicate its results with the parent.
    weak var resultsDelegate: ResultsDelegate?
    
    let client = MovieDBClient()
    
    // Other Properties
    lazy var actorsDataSource = {
        return ActorSelectionDataSource(tableView: tableView)
    }()
    
    lazy var actorsSelectionDelegate = {
        return SelectionTableDelegate(doneButton: doneBarButton, selectedItemsLabel: numberOfSelectedActorsLabel)
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
                self?.actorsDataSource.update(with: actors)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - Done Button
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let selectedItems = tableView.indexPathsForSelectedRows {
            let actors = selectedItems.map { actorsDataSource.actor(at: $0) }
            
            resultsDelegate?.actorsSelected(actors)
            
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

