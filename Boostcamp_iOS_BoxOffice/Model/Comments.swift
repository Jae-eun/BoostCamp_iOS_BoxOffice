//
//  Comments.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 14/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import Foundation

struct CommentsAPIResponse: Codable {
    let comments: [Comments]
}

struct Comments: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
}
