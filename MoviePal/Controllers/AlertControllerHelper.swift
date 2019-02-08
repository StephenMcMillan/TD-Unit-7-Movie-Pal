//
//  AlertControllerHelper.swift
//  MoviePal
//
//  Created by Stephen McMillan on 07/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation
import UIKit

func errorAlert(for error: Error, actionCompletion: @escaping () -> Void) -> UIAlertController {
    
    let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
    
    let dismissAction = UIAlertAction(title: "Ok", style: .default) { _ in
        actionCompletion()
    }
    
    alertController.addAction(dismissAction)
    
    return alertController
}
