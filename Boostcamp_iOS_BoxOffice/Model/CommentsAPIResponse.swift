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
    let movieId: String
    
    enum CodingKeys: String, CodingKey {
        case comments
        case movieId = "movie_id"
    }
}
