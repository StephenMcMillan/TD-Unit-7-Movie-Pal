//
//  SuggestedMoviesDataSource.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class SuggestedMoviesDataSource: NSObject, UITableViewDataSource {
    
    private var movies: [Movie] = []
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
        
    // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = movie.originalTitle
        cell.detailTextLabel?.text = movie.releaseDate
        
        return cell
    }
    
    // MARK: Data Updating
    func update(with movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func movie(at index: IndexPath) -> Movie {
        return movies[index.row]
    }
    
    
}
