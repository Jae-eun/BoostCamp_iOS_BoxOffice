//
//  Netwrok.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by Presto on 20/01/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import Foundation

class Network {
    
    class func get(_ url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            if statusCode == 200 {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }
}
