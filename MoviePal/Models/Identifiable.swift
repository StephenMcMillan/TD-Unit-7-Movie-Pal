//
//  Identifiable.swift
//  MoviePal
//
//  Created by Stephen McMillan on 06/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import Foundation
protocol Identifiable {
    var name: String { get }
    var id: Int { get }
}
