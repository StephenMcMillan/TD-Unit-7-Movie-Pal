//
//  MinimumRatingSelectionController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 07/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class MinimumRatingSelectionController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var resultsDelegate: ResultsDelegate?
    
    var selectedMinimumRating: Int? = nil {
        didSet {
            doneButton.isEnabled = selectedMinimumRating != nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            selectedMinimumRating = 5
        case 1:
            selectedMinimumRating = 4
        case 2:
            selectedMinimumRating = 3
        case 3:
            selectedMinimumRating = 2
        case 4:
            selectedMinimumRating = 1
        default:
            break
        }
    }

    // MARK: - Navigation
     
     @IBAction func doneAction(_ sender: Any) {        resultsDelegate?.minimumRatingSelected(selectedMinimumRating!)
        navigationController?.dismiss(animated: true, completion: nil)
     }
}
