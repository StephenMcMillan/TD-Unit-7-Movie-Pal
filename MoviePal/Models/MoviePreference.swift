//
//  MoviePreference.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

/// A type to represent all a users preferences when it comes to choosing a movie
class MoviePreference {
    var preferedGenres: [Genre] = []
    var preferedActors: [Person] = []
    
    var isConfigured: Bool {
        return !preferedGenres.isEmpty && !preferedActors.isEmpty
    }
    
}
