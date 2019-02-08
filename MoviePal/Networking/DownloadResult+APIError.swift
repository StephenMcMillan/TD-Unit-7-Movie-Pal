//
//  DownloadResult+APIError.swift
//  MoviePal
//
//  Created by Stephen McMillan on 07/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

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
