//
//  Request.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 14/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import Foundation

let DidReceiveMoviesNotification: Notification.Name = Notification.Name("DidReceiveMovies")
let DidReceiveMovieInfoNotification: Notification.Name = Notification.Name("DidReceiveMovieInfo")
let DidReceiveCommentsNotification: Notification.Name = Notification.Name("DidReceiveComments")

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

            NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo: ["movies": apiResponse.movies])
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
            let apiResponse: MovieInfoAPIResponse = try JSONDecoder().decode(MovieInfoAPIResponse.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo: ["movieInfo": apiResponse.movieInfo])
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}

func requestComments(id: String) {
    guard let url = URL(string: "\(baseUrl)/comments?movie_id=\(id)") else {
        print("Comment Url cannot connect")
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
            
            NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo: ["comments": apiResponse.comments])
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}
