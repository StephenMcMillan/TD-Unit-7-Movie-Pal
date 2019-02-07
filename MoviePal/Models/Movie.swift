//
//  Movie.swift
//  MoviePal
//
//  Created by Stephen McMillan on 06/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

/// A model of the wrapper that the discover/movie endpoint returns
struct MoviesWrapper: ResultsWrapper {
    let page: Int
    let totalPages: Int
    let results: [Movie]
}

/// A model of an individual movie returned from the movie database
struct Movie: Decodable {
    let id: Int
    let originalTitle: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    
    // Images
    let posterPath: String?
    let backdropPath: String?
    
}
