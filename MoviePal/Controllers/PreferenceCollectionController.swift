//
//  PreferenceCollectionController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

/// A Delegate to allow selection views to communicate with this hub / entry view controller.
protocol ResultsDelegate: class {
    func genresSelected(_ genres: [Genre])
    func actorsSelected(_ actors: [Person])
    func minimumRatingSelected(_ rating: Int)
}

/// Entry point of the application. Responsbile for collecting movie preferences for two people and presenting a results controller.
class PreferenceCollectionController: UIViewController {

    // Outlets
    @IBOutlet weak var firstPersonBubble: SpeechBubbleButton!
    @IBOutlet weak var secondPersonBubble: SpeechBubbleButton!
    @IBOutlet weak var viewResultsButton: UIButton!
        
    // Properties
    var firstPersonPreferences = MoviePreference()
    var secondPersonPreferences = MoviePreference()
    var focusedPersonPreferences: MoviePreference? // Focused person if selection views are displayed.
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDisplay() // Checks if either users preferences are configured and adjusts the view respectively
    }
    
    
    // MARK: - Speech Bubble Setup
    func updateDisplay() {
        firstPersonBubble.isConfigured = firstPersonPreferences.isConfigured
        secondPersonBubble.isConfigured = secondPersonPreferences.isConfigured
        
        viewResultsButton.isEnabled = true
        
        if firstPersonPreferences.isConfigured && secondPersonPreferences.isConfigured {
            viewResultsButton.isEnabled = true
        }
    }
    
    // MARK: - Speech Bubble Button Actions
    @IBAction func firstPersonBubblePressed() {
        focusedPersonPreferences = firstPersonPreferences
    }
    
    @IBAction func secondPersonBubblePressed() {
        focusedPersonPreferences = secondPersonPreferences
    }
    
    // MARK: - View Results Action
    @IBAction func viewResults() {
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            
            if let genresSelectionController = navigationController.topViewController as? GenreSelectionController {
                genresSelectionController.resultsDelegate = self
            }
            
            if let suggestedMoviesController = navigationController.topViewController as? SuggestedMoviesController {
                let preferences = MoviePreference.matchedPreference(from: firstPersonPreferences, and: secondPersonPreferences)
                dump(preferences)
                suggestedMoviesController.commonMoviePreference = preferences
            }
        
        
        }
    }
}

extension PreferenceCollectionController: ResultsDelegate {
    func genresSelected(_ genres: [Genre]) {
        focusedPersonPreferences?.preferedGenres = genres
    }
    
    func actorsSelected(_ actors: [Person]) {
        focusedPersonPreferences?.preferedActors = actors
        //focusedPersonPreferences = nil // Finished setting values...
    }
    
    func minimumRatingSelected(_ rating: Int) {
        focusedPersonPreferences?.minimumRating = rating
        
    }
}
