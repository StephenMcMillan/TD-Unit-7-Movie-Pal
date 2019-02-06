//
//  Person.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

/// A wrapper that makes it easy to decode an array of people using a JSONDecoder.
struct PeopleWrapper: Decodable {
    let page: Int // The current page of people
    let totalPages: Int // The total number of pages the endpoint has available
    let results: [Person]
}

/// Representation of Someone in the movie world. Actor, crew etc.
struct Person: Decodable {
    let id: Int
    let name: String
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
