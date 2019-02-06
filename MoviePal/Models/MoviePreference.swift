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
    
    var genreIds: [Int] {
        return preferedGenres.map { $0.id }
    }
    
    var actorIds: [Int] {
        return preferedActors.map { $0.id } //FIXME: Add an extension of types with IDs
    }
    
    var isConfigured: Bool {
        return !preferedGenres.isEmpty && !preferedActors.isEmpty
    }
    
    /// This function takes two movie preferences and returns a matched preferences type.
    /// Route A: Use a Set to get all the unique actor and genre IDs.
    /// * Route B: Find the common Genre IDs and Actor IDs. If there are no common genres or actors then use the set method.
    static func matchedPreference(from firstPreference: MoviePreference, and secondPreference: MoviePreference) -> MoviePreference {
        
        let matched = MoviePreference()
        
        // Try and get an array of common genres and actors between the two preferences.
        matched.preferedGenres = firstPreference.preferedGenres.filter { return secondPreference.preferedGenres.contains($0) }
        matched.preferedActors = firstPreference.preferedActors.filter { return secondPreference.preferedActors.contains($0) }
        
        if matched.preferedGenres.isEmpty {
            // There were no common genres so combine both peoples prefered genres as the result.
            matched.preferedGenres = firstPreference.preferedGenres + secondPreference.preferedGenres
        }
        
        if matched.preferedActors.isEmpty {
            matched.preferedActors = firstPreference.preferedActors + secondPreference.preferedActors
        }
        
        return matched
        
    }
    
}
