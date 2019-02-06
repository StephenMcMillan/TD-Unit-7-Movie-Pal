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
        
        // A abit of extra work needed because the genres endpoint has a wrapper.
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
        
        let popularActorsEndpoint = MovieDB.people(page: 1)
        
        download(from: popularActorsEndpoint.request) { (result: DownloadResult<PeopleWrapper, APIError>) in
            switch result {
                
            case .success(let peopleWrapper):
                completion(.success(peopleWrapper.results)) // Pass only the results from the wrapper through.
                
            case .failure(let error):
                completion(.failure(error)) // Bubble up the error
            }
        }
    }
    
    func getMovies(matching preference: MoviePreference, completionHandler completion: @escaping (DownloadResult<[Movie], APIError>) -> Void) {
        
        let discoverEndpoint = MovieDB.discoverMovies(genres: preference.genreIds, people: preference.actorIds)
        
        download(from: discoverEndpoint.request) { (result: DownloadResult<MoviesWrapper, APIError>) in
            switch result {
                
            case .success(let moviesWrapper):
                completion(.success(moviesWrapper.results))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }

    }
    
    
}
