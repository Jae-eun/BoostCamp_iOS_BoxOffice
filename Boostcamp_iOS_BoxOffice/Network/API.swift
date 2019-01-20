//
//  API.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by Presto on 20/01/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import Foundation

class API {
    
    static let shared = API()
    
    let baseURL = "http://connect-boxoffice.run.goorm.io"
    
    func requestMovies(orderType: Int) {
        guard let url = URL(string: "\(baseURL)/movies?order_type=\(orderType)") else { return }
        Network.get(url) { data, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(MoviesAPIResponse.self, from: data)
                    NotificationCenter.default.post(name: .didReceiveMoviesNotification, object: nil, userInfo: ["movies": apiResponse.movies])
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func requestMovieInfo(id: String) {
        guard let url = URL(string: "\(baseURL)/movie?id=\(id)") else { return }
        Network.get(url) { data, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(MovieInfoAPIResponse.self, from: data)
                    NotificationCenter.default.post(name: .didReceiveMovieInfoNotification, object: nil, userInfo: ["movieInfo": apiResponse])
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func requestComments(id: String) {
        guard let url = URL(string: "\(baseURL)/comments?movie_id=\(id)") else { return }
        Network.get(url) { data, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(CommentsAPIResponse.self, from: data)
                    NotificationCenter.default.post(name: .didReceiveCommentsNotification, object: nil, userInfo: ["comments": apiResponse.comments])
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}
