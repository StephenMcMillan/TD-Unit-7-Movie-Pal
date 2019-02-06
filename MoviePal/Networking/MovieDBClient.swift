//
//  MovieDBClient.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

class MovieDBClient: APIClient {
    
    func getGenres(completionHandler completion: @escaping (DownloadResult<[Genre], APIError>) -> Void) {
        
        // Create a url request point the the genres endpoint of the API.
        let genresEndpoint = MovieDB.genres
        
        // A abit of extra work needed because the genres endpoint has a wrapper.
        download(from: genresEndpoint.urlRequest) { (result: DownloadResult<GenreWrapper, APIError>) in
            switch result {
            case .success(let genreWrapper):
                completion(.success(genreWrapper.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
