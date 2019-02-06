//
//  GenreSelectionDataSource.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation
import UIKit

class GenreSelectionDataSource: NSObject, UITableViewDataSource {
    
    /* Stub Genre Data
    var genres: [Genre] = [Genre(id: 28, name: "Action"), Genre(id: 12, name: "Adventure"), Genre(id: 16, name: "Animation"), Genre(id: 35, name: "Comedy"), Genre(id: 80, name: "Crime"), Genre(id: 99, name: "Documentary"), Genre(id: 18, name: "Drama"), Genre(id: 10751, name: "Family"), Genre(id: 14, name: "Fantasy"), Genre(id: 36, name: "History"), Genre(id: 27, name: "Horror"), Genre(id: 10402, name: "Music"), Genre(id: 9648, name: "Mystery"), Genre(id: 10749, name: "Romance"), Genre(id: 878, name: "Science Fiction"), Genre(id: 10770, name: "TV Movie"), Genre(id: 53, name: "Thriller"), Genre(id: 10752, name: "War"), Genre(id: 37, name: "Western")]
     */
    
    private var genres = [Genre]()
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    // MARK: - Table View Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferenceCell.reuseIdentifier, for: indexPath) as! PreferenceCell
        
        cell.preferenceDescriptionLabel.text = genres[indexPath.row].name
        return cell
    }
    
    // MARK: - Update Data
    func update(with genres: [Genre]) {
        self.genres = genres
        tableView.reloadData()
    }
    
    func object(at index: IndexPath) -> Genre {
        return genres[index.row]
    }
    
}
