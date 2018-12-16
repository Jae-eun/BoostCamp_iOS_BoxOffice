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

struct Movies: Codable {
    let grade: Int
    let thumb: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case grade, thumb, title, date, id
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case reservationGrade = "reservation_grade"
    }
    
    var movieTableInfo: String {
        return "평점 : \(userRating) 예매순위 : \(grade) 예매율 : \(reservationRate)"
    }
    
    var movieCollectionInfo: String {
        return "\(reservationGrade)위(\(userRating)) / \(reservationRate)%"
    }
    
    var setGradeImageName: String {
        if grade == 0 {
            return "ic_allages"
        } else {
            return "ic_\(grade)"
        }
    }
}
