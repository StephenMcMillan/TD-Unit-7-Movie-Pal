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
    var minimumRating: Int = 5
    
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
        
        // Create a Set of Genres and Actors containing the elements that both users selected.
        let matchedGenresSet = Set(firstPreference.preferedGenres).intersection(secondPreference.preferedGenres)
       
        // Return all actors, only match on genres of interest because data set is smaller.
        let matchedActorsSet = Set(firstPreference.preferedActors).union(secondPreference.preferedActors)
        
        if firstPreference.minimumRating > secondPreference.minimumRating {
            matched.minimumRating = firstPreference.minimumRating
        } else {
            matched.minimumRating = secondPreference.minimumRating
        }
        
        // Check if the common genres or actors sets are empty.
        // If so: The two users had no common interests so just return a combination of both their interests.
        // If not empty: Return the set so that the movies returned will be more specific to what the two users like.
        matched.preferedGenres = matchedGenresSet.isEmpty ? (firstPreference.preferedGenres + secondPreference.preferedGenres) : Array(matchedGenresSet)
        matched.preferedActors = Array(matchedActorsSet)
        
        //matched.preferedActors = matchedActorsSet.isEmpty ? (firstPreference.preferedActors + secondPreference.preferedActors) : Array(matchedActorsSet)
        
        return matched
        
    }
    
}
