//
//  MovieInfo.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 14/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import Foundation

//struct MovieInfoAPIResponse: Codable {
//    let movieInfo: [MovieInfo]
//}

struct MovieInfo: Codable {
    let audience: Int
    let grade: Int
    let actor: String
    let duration: Int
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let director: String
    let id: String
    let image: String
    let synopsis: String
    let genre: String
    
    enum CodingKeys: String, CodingKey {
        case audience, grade, actor, duration, title, date, director, id, image, synopsis, genre
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
   
    var reservationRateText: String {
        return "\(reservationGrade)위 \(reservationRate)%"
    }
    
    var GenreAndDurationText: String {
        return "\(genre)/\(duration)분"
    }
    
    var setGradeImageName: String {
        if grade == 0 {
            return "ic_allages"
        } else {
            return "ic_\(grade)"
        }
    }
}

