//
//  MovieCollectionViewController.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier: String = "CollectionCell"
    var movies: [Movies] = []

    var gradeImageName: String?
    var orderNumber: Int?
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        addRefreshControl()
    }
    
    func addRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc func refresh(_ sender: Any){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.collectionView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)
        
        orderNumber = getOrderTypeUserDefaults()
        if let orderNumber = orderNumber {
            setNaviBarTitle(orderType: orderNumber)
            requestMovies(orderType: orderNumber)
        }
    }
    
    @objc func didReceiveMoviesNotification(_ noti: Notification) {
        guard let movies: [Movies] = noti.userInfo?["movies"] as? [Movies] else { return  }
        
        self.movies = movies
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    @IBAction func touchUpSettingButton(_ sender: UIBarButtonItem) {
        setOrderMoviesActionSheet()
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let movie: Movies = self.movies[indexPath.item]
        
        cell.movieTitleLabel.text = movie.title
        cell.gradeImageView.image = UIImage(named: movie.setGradeImageName)
        cell.movieInfoLabel.text = movie.movieCollectionInfo
        cell.releaseDateLabel.text = movie.date
        cell.movieImageView.image = nil
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = collectionView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.movieImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }
    
    func setGradeImage(grade: Int) -> String {
        if grade == 12 || grade == 15 || grade == 19 {
            gradeImageName =  "ic_\(grade)"
        } else {
            gradeImageName = "ic_allages"
        }
        return gradeImageName ?? " "
    }
}

extension MovieCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        
        guard let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        movieDetailViewController.title = movie.title
        movieDetailViewController.movieId = movie.id

        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
