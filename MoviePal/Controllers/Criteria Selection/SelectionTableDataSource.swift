//
//  SelectionTableDataSource.swift
//  MoviePal
//
//  Created by Stephen McMillan on 06/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

/// A generic data source that can display identifiable objects. Eg genres and actors that have names and ids
class SelectionTableDataSource<Object: Identifiable>: NSObject, UITableViewDataSource {
    
    private var objects = [Object]()
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PreferenceCell.reuseIdentifier, for: indexPath) as! PreferenceCell
        
        cell.preferenceDescriptionLabel.text = objects[indexPath.row].name
        return cell
    }
    
    // Update the dataset and reload the tableview
    func update(with objects: [Object]) {
        self.objects = objects
        tableView.reloadData()
    }
    
    // Get object at Index
    func object(at index: IndexPath) -> Object {
        return objects[index.row]
    }
}
