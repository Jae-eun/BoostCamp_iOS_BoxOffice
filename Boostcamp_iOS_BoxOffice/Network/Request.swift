//
//  Request.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 14/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import Foundation



let baseUrl: String = "http://connect-boxoffice.run.goorm.io/"

func requestMovies(orderType: Int) {
    guard let url = URL(string: "\(baseUrl)/movies?order_type=\(orderType)") else {
        print("Movies Url cannot connect")
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        print(session)

        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let data = data else { return }

        do {
            let apiResponse: MoviesAPIResponse = try JSONDecoder().decode(MoviesAPIResponse.self, from: data)

            NotificationCenter.default.post(name: .didReceiveMoviesNotification, object: nil, userInfo: ["movies": apiResponse.movies])
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}

func requestMovieInfo(id: String) {
    guard let url = URL(string: "\(baseUrl)//movie?id=\(id)") else {
        print("MovieInfo Url cannot connect.")
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        print(session)
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: MovieInfo = try JSONDecoder().decode(MovieInfo.self, from: data)
            
            NotificationCenter.default.post(name: .didReceiveMovieInfoNotification, object: nil, userInfo: ["movieInfo": apiResponse])
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}

func requestComments(id: String) {
    guard let url = URL(string: "\(baseUrl)/comments?movie_id=\(id)") else {
        print("Comments Url cannot connect")
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        print(session)
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: CommentsAPIResponse = try JSONDecoder().decode(CommentsAPIResponse.self, from: data)
            
            NotificationCenter.default.post(name: .didReceiveCommentsNotification, object: nil, userInfo: ["comments": apiResponse.comments])
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}
