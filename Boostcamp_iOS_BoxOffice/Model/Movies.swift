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
    let thumb: String
    let reservation_grade: Int
    let reservation_rate: Double
    let date: String
    let grade: Int
    let title: String
    let id: String
    let user_rating: Double
    
    var movieInfo: String {
        return "평점 : \(reservation_rate) 예매순위 : \(grade) 예매율 : \(user_rating)"
    }
}
