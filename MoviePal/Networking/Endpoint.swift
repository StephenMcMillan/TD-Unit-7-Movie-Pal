//
//  Endpoint.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

/// Modeling the endpoints needed on the MovieDB API
typealias ID = Int

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents(string: baseUrl)! // If the url isn't correct, crash so we can fix it.
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    var request: URLRequest {
        return URLRequest(url: urlComponents.url!) // Again, crash if we can't create a request because this would need addressed.
    }
    
    /// Returns a URLRequest that has a page query item with the value set to whatever is passed in.
    func request(forPage page: Int) -> URLRequest {
        var components = urlComponents
        components.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        return URLRequest(url: components.url!)
    }
}

enum MovieDB {
    /// Get all the genres
    case genres
    
    /// Get a list of popular movie folks
    case people
    
    /// Get movies filtered that have genre ids and people ids
    case discoverMovies(genres: [ID], people: [ID])
    
    // Get details of a movie with a specific id
    case movie(id: ID)
    
    // Gets the poster image url
    case poster(path: String)
    
    case backdrop(path: String)
}

extension MovieDB: Endpoint {
    var baseUrl: String {
        
        switch self {
        case .genres, .people, .discoverMovies, .movie:
            return "https://api.themoviedb.org"
        case .poster, .backdrop:
             return "https://image.tmdb.org"
        }
    }
    
    var path: String {
        switch self {
        case .genres:
            return "/3/genre/movie/list"
        case .people:
            return "/3/person/popular"
        case .discoverMovies:
            return "/3/discover/movie"
        case .movie(let movieID):
            return "/3/movie/\(movieID)"
        case .poster(let path):
            return "/t/p/w92\(path)"
        case .backdrop(let path):
            return "/t/p/w780\(path)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        var queryItems = [URLQueryItem]()
        
        // Add API key
        switch self {
        case .poster, .backdrop:
            break
        default:
            queryItems.append(URLQueryItem(name: "api_key", value: "f8b49a609c7bcf96aa3bdf2042ada35f")) // Add api key for every request.
        }
        
        // Additional Query Params
        switch self {

        case .discoverMovies(let genreIDs, let peopleIDs):
            
            // Appends the genres and people filter to the request.
            // Genre IDs and People IDs are converted to a query string, separated by the |/OR filter. This means that movies contain x genre OR y genre as well as x or y person will be returned insteadof x AND y genre.
            // Less strict filter = less accurate results but more results.
            queryItems.append(contentsOf: [
                URLQueryItem(name: "with_genres", value: genreIDs.asORQueryString()),
                URLQueryItem(name: "with_people", value: peopleIDs.asORQueryString())
                ])
        default:
             break
        }
        
        return queryItems
    }
}

// A little helper to transform an array of ints eg. [28, 12, 10] to a query string that is recognisable by the movie db api. Eg: [28, 12, 10] becomes "28|12|10"... Used for genre IDs and People IDs.
extension Array where Element: CustomStringConvertible {
    func asORQueryString() -> String {
        let strings = self.map { $0.description }
        let joinedStrings = strings.joined(separator: "|")
        return joinedStrings
    }
}
