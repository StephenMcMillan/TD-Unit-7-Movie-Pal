//
//  CustomDecoder.swift
//  MoviePal
//
//  Created by Stephen McMillan on 06/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static let movieDBDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // Movie DB describes keys using snakecase eg. total_pages
        return decoder
    }()
}
