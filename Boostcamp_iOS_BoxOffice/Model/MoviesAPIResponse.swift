//
//  Movies.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import Foundation

struct MoviesAPIResponse: Codable {
    let movies: [Movies]
    let orderType: Int
    
    enum CodingKeys: String, CodingKey {
        case movies
        case orderType = "order_type"
    }
}
