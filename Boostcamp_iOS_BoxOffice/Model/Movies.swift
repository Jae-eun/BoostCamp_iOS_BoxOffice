//
//  Movies.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    let movies: [Movies]
}

struct Movies: Codable {
    let grade: Int
    let thumb: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String

    
    var movieTableInfo: String {
        return "평점 : \(reservation_rate) 예매순위 : \(grade) 예매율 : \(user_rating)"
    }
    
    var movieCollectionInfo: String {
        return "\(reservation_grade)위(\(user_rating)) / \(reservation_rate)%"
    }
}
