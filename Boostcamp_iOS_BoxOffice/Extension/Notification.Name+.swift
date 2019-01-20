//
//  Notification.Name+.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by Presto on 20/01/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReceiveMoviesNotification: Notification.Name = Notification.Name("DidReceiveMovies")
    
    static let didReceiveMovieInfoNotification: Notification.Name = Notification.Name("DidReceiveMovieInfo")
    
    static let didReceiveCommentsNotification: Notification.Name = Notification.Name("DidReceiveComments")
}
