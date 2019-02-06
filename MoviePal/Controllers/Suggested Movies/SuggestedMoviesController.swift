//
//  SuggestedMoviesController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class SuggestedMoviesController: UITableViewController {

    var commonMoviePreference: MoviePreference?
    
    let client = MovieDBClient()
    
    lazy var moviesDataSource: SuggestedMoviesDataSource = {
        return SuggestedMoviesDataSource(tableView: tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = moviesDataSource
        tableView.delegate = self
        
        getMovies()
    }
    
    func getMovies() {
        // Download movies that match the preference model.
        
        guard let preferences = commonMoviePreference else { return }
        
        client.getMovies(matching: preferences) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.moviesDataSource.update(with: movies)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func startOver(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow, let movieDetailController = segue.destination as? MovieDetailController {
            movieDetailController.movie = moviesDataSource.movie(at: selectedIndexPath)
        }

    }
    
    deinit {
        print("BYE")
    }
}
