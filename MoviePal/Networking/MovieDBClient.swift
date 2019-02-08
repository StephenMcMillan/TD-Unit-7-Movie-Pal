//
//  MovieDBClient.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

class MovieDBClient: APIClient {
    
    /// Attempts to download all the popular movies genres from the Movie Database.
    func getGenres(completionHandler completion: @escaping (DownloadResult<[Genre], APIError>) -> Void) {
        
        let genresEndpoint = MovieDB.genres
        
        // A abit of extra work needed because the genres endpoint wrapper is not the same format as the actors or movies.
        download(from: genresEndpoint.request) { (result: DownloadResult<GenreWrapper, APIError>) in
            switch result {
                
            case .success(let genreWrapper):
                completion(.success(genreWrapper.genres))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPopularActors(completionHandler completion: @escaping (DownloadResult<[Person], APIError>) -> Void) {
        // Gets 4 pages of popular actors for users to select from...
        downloadWrapper(ofType: PeopleWrapper.self, from: MovieDB.people, upToPage: 4, withCompletion: completion)
    }
    
    func getMovies(matching preference: MoviePreference, completionHandler completion: @escaping (DownloadResult<[Movie], APIError>) -> Void) {
        
        let discoverEndpoint = MovieDB.discoverMovies(genres: preference.genreIds, people: preference.actorIds, minimumRating: preference.minimumRating)
        
        /// Downloads movies that match the preferences above. In this instance 2 pages of results are downloaded.
        downloadWrapper(ofType: MoviesWrapper.self, from: discoverEndpoint, upToPage: 2, withCompletion: completion)

    }
    
    
}
