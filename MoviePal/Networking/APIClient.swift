//
//  APIClient.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

// A blueprint for API Client functionality

/// Model of a download result
///
/// - success: Returned if the download succeeds. Generic T is data.
/// - failure: Returned if the download fails. Generic E is some error.
enum DownloadResult<T, E: Error> {
    case success(T)
    case failure(E)
}

enum APIError: Error, LocalizedError {
    case requestFailed
    case requestUnsuccessful(Int)
    case missingData
    case decodingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "The request failed during the download process."
        case .requestUnsuccessful(let statusCode): return "The request was unsuccessful with status code: \(statusCode)."
        case .missingData: return "There was an issue unpacking the data retrieved from the server. Try again."
        case .decodingFailure: return "Unable to successfully decode the data retrieved from the server to the expected object."
        }
    }
}

protocol APIClient {
    func download<Object: Decodable>(from request: URLRequest, completionHandler completion: @escaping (DownloadResult<Object, APIError>) -> Void)
    func download<Object: Decodable>(from request: URLRequest, completionHandler completion: @escaping (DownloadResult<[Object], APIError>) -> Void)
}

extension APIClient {
    
    // Provides default implementations for the two generic download functions.
    
    /// Download a generic decodable object and return that object.
    func download<Object: Decodable>(from request: URLRequest, completionHandler completion: @escaping (DownloadResult<Object, APIError>) -> Void) {
        
        downloadJSON(request: request) { data, apiError in
            
            guard let data = data else {
                let resultantError = apiError ?? APIError.missingData
                completion(.failure(resultantError))
                return
            }
            
            do {
                // 1. Try to decode a generic decodable object.
                let decodedObjects = try JSONDecoder().decode(Object.self, from: data)
                
                // 2. Decoded from JSON successfully, return the object.
                completion(.success(decodedObjects))
                
            } catch {
                // Something went wrong during the decoding stage.
                completion(.failure(.decodingFailure))
            }
            
        }
    }

    /// Download an array of generic decodable objects and returns an array of the decoded type.
    func download<Object: Decodable>(from request: URLRequest, completionHandler completion: @escaping (DownloadResult<[Object], APIError>) -> Void) {
        
        downloadJSON(request: request) { data, apiError in
            
            guard let data = data else {
                let resultantError = apiError ?? APIError.missingData
                completion(.failure(resultantError))
                return
            }
            
            do {
                // 1. Try to decode an array of generic decodable objects.
                let decodedObjects = try JSONDecoder().decode([Object].self, from: data)
                
                // 2. Decoded from JSON successfully, return the objects.
                completion(.success(decodedObjects))
                
            } catch {
                // Something went wrong during the decoding stage.
                completion(.failure(.decodingFailure))
            }
            
        }
    }
    
    /// Downloads json from a request.
    func downloadJSON(request: URLRequest, completionHandler completion: @escaping (Data?, APIError?) -> Void ) {
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            // The background download is finished, switch to the main queue and process the result.
            DispatchQueue.main.async {
                // Error should be nil if request was successful.
                guard error == nil else {
                    completion(nil, APIError.requestFailed) // FIXME: maybe propogate this up for internet connection errors.
                    return
                }
                
                // HTTP Status code should be 200-299 to indicate a successful request.
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(nil, APIError.requestUnsuccessful((response as! HTTPURLResponse).statusCode))
                    return
                }
                
                // By this stage there shoulpo90p7898054321§ be valid data.
                guard let data = data else {
                    completion(nil, APIError.missingData)
                    return
                }
                print(data)
                
                completion(data, nil)
                
            }
             
        }
        task.resume()
    }
}
