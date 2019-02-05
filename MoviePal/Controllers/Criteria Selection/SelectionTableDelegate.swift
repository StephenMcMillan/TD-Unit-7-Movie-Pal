//
//  SelectionTableDelegate.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class SelectionTableDelegate: NSObject, UITableViewDelegate {
    
    weak var doneButton: UIBarButtonItem?
    weak var selectedItemsLabel: UILabel?
    
    init(doneButton: UIBarButtonItem, selectedItemsLabel: UILabel) {
        self.doneButton = doneButton
        self.selectedItemsLabel = selectedItemsLabel
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard (tableView.indexPathsForSelectedRows?.count ?? 0) < 5 else {
            return nil
        }
        
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        doneButton?.isEnabled = tableView.indexPathsForSelectedRows?.count ?? 0 > 0 ? true : false
        selectedItemsLabel?.text = "\(tableView.indexPathsForSelectedRows?.count ?? 0) of 5 selected"
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        doneButton?.isEnabled = tableView.indexPathsForSelectedRows?.count ?? 0 > 0 ? true : false
        selectedItemsLabel?.text = "\(tableView.indexPathsForSelectedRows?.count ?? 0) of 5 selected"
    }
}
