//
//  MovieTableViewController.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit
import Foundation

class MovieTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "TableCell"
    var movies: [Movies] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)

       requestMovies(orderType: 0)
    }
    
    @objc func didReceiveMoviesNotification(_ noti: Notification) {
        guard let movies: [Movies] = noti.userInfo?["movies"] as? [Movies] else { return  }
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

extension MovieTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie: Movies = self.movies[indexPath.row]
        
        cell.movieTitleLabel.text = movie.title
        cell.gradeImageView.image = UIImage(named: movie.setGradeImageName)
        cell.movieInfoLabel.text = movie.movieTableInfo
        cell.releaseDateLabel.text = "개봉일 : \(movie.date)"
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
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
}

extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        guard let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
            movieDetailViewController.title = movie.title
            movieDetailViewController.movieId = movie.id

            navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
