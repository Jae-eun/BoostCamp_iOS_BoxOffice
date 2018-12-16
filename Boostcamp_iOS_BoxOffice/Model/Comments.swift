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

struct Comments: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case rating, timestamp, writer, contents, id
        case movieId = "movie_id"
    }
    
    var timestampToDateFormat: String {
        let timestamp = Date(timeIntervalSince1970: self.timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: timestamp)
    }
}
