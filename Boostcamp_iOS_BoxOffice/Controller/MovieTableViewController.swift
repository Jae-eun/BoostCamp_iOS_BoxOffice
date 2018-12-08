//
//  MovieTableViewController.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit

class MovieTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "TableCell"
    var movies: [Movies] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=0") else { return }
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.movies = apiResponse.movies
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
}

    extension MovieTableViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
            
            let movie: Movies = self.movies[indexPath.row]
            
            cell.movieTitleLabel.text = movie.title
            cell.movieInfoLabel.text = movie.movieInfo
            cell.releaseDateLabel.text = "개봉일 : \(movie.date)"
            cell.movieImageView.image = nil
            
            DispatchQueue.global().async {
                guard let imageURL: URL = URL(string: movie.thumb) else { return }
                guard  let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                
                DispatchQueue.main.async {
                    if let index: IndexPath = tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            cell.movieImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            return cell
        }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return movies.count
            }
        
    }
    extension MovieTableViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160
        }
    }


