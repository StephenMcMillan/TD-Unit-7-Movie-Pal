//
//  Person.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

protocol ResultsWrapper: Decodable {
    associatedtype Result
    
    var page: Int { get }
    var totalPages: Int { get }
    var results: [Result] { get }
}


/// A wrapper that makes it easy to decode an array of people using a JSONDecoder.
struct PeopleWrapper: ResultsWrapper {
    let page: Int // The current page of people
    let totalPages: Int // The total number of pages the endpoint has available
    let results: [Person]
}

/// Representation of Someone in the movie world. Actor, crew etc.
struct Person: Decodable, Identifiable {
    let id: Int
    let name: String
}

extension Person: Equatable, Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
