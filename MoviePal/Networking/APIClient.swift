//
//  APIClient.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

// A blueprint for API Client functionality

protocol APIClient {
    func downloadWrapper<Wrapper: ResultsWrapper>(ofType type: Wrapper.Type, from endpoint: Endpoint, upToPage maxPage: Int, withCompletion completion: @escaping (DownloadResult<[Wrapper.Result], APIError>) -> Void)
    func download<Object: Decodable>(from request: URLRequest, completionHandler completion: @escaping (DownloadResult<Object, APIError>) -> Void)
    func download<Object: Decodable>(from request: URLRequest, completionHandler completion: @escaping (DownloadResult<[Object], APIError>) -> Void)
}

extension APIClient {
    
    func downloadWrapper<Wrapper: ResultsWrapper>(ofType type: Wrapper.Type, from endpoint: Endpoint, upToPage maxPage: Int, withCompletion completion: @escaping (DownloadResult<[Wrapper.Result], APIError>) -> Void) {
        
        var currentPage = 1
        var combinedResults = [Wrapper.Result]()
        
        func downloadPage() {
            
            let request = endpoint.request(forPage: currentPage)
            
            download(from: request) { (result: DownloadResult<Wrapper, APIError>) in
                switch result {
                case .success(let wrapper):
                    
                    // Recursively download until currentPage == pages required.
                    combinedResults += wrapper.results
                    
                    if wrapper.page < maxPage {
                        currentPage += 1 // Try to get the next page
                        downloadPage()
                    } else {
                        // All the requested pages are downloaded.
                        completion(.success(combinedResults))
                    }
                    
                case .failure(let error):
                    completion(.failure(error)) // Stop download, leave scope through completion handler.
                }
            }
        }
        
        downloadPage()
        
    }
    
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
                let decodedObjects = try JSONDecoder.movieDBDecoder.decode(Object.self, from: data)
                
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
                let decodedObjects = try JSONDecoder.movieDBDecoder.decode([Object].self, from: data)
                
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
