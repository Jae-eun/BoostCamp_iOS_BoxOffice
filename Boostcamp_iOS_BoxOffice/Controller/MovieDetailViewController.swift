//
//  MovieDetailViewController.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifiers: [String] = ["MovieInfoCell", "SynopsisCell", "DirectorCell", "CommentsCell"]
    
    var movieInfo: MovieInfo?
    var comments: [Comments]?
    var movieId: String?

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
            return 1
        default:
            return comments?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieInfoNotification(_:)), name: DidReceiveMovieInfoNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCommentsNotification(_:)), name: DidReceiveCommentsNotification, object: nil)
        
        requestMovieInfo(id: movieId ?? " ")
        requestComments(id: movieId ?? " ")
    }

    @objc func didReceiveMovieInfoNotification(_ noti: Notification) {
        guard let movieInfo: MovieInfo = noti.userInfo?["movieInfo"] as? MovieInfo else { return  }
        self.movieInfo = movieInfo
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    @objc func didReceiveCommentsNotification(_ noti: Notification) {
        guard let comments: [Comments] = noti.userInfo?["comments"] as? [Comments] else { return  }
        self.comments = comments
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[section], for: indexPath)
        
        guard let movieInfo = movieInfo else { return UITableViewCell() }
        
        switch section {
        case 0:
            guard let movieInfoCell = cell as? MovieInfoTableViewCell else {
                return UITableViewCell()
            }
            movieInfoCell.movieTitleLabel.text = movieInfo.title
            movieInfoCell.gradeImageView.image = UIImage(named: movieInfo.setGradeImageName)
            movieInfoCell.releaseDateLabel.text = movieInfo.date
            movieInfoCell.detailLabel.text = movieInfo.GenreAndDurationText
            movieInfoCell.reservationRateLabel.text = movieInfo.reservationRateText
            movieInfoCell.userRatingLabel.text = "\(movieInfo.userRating)"
            movieInfoCell.audienceLabel.text = "\(movieInfo.audience)"
            
            DispatchQueue.global().async {
                guard let imageURL: URL = URL(string: movieInfo.image) else { return }
                guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                
                DispatchQueue.main.async {
                    if let index: IndexPath = tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            movieInfoCell.movieImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }

        case 1:
            guard let synopsisCell = cell as? SynopsisTableViewCell else {
                return UITableViewCell()
            }
            synopsisCell.synopsisLabel.text = movieInfo.synopsis

        case 2:
            guard let directorCell = cell as? DirectorTableViewCell else {
                return UITableViewCell()
            }
            directorCell.directorLabel.text = movieInfo.director
            directorCell.actorLabel.text = movieInfo.actor
            
        case 3:
            guard let commentsCell = cell as? CommentsTableViewCell else {
                return UITableViewCell()
            }
            if let comments = comments {
                if indexPath.row == 0 {
                    commentsCell.commentTitleLabel.isHidden = false
                    commentsCell.composeButton.isHidden = false
                } else {
                    commentsCell.commentTitleLabel.isHidden = true
                    commentsCell.composeButton.isHidden = true
                }
                commentsCell.writerLabel.text = comments[indexPath.row].writer
                commentsCell.timestampLabel.text = "\(comments[indexPath.row].timestampToDateFormat)"
                commentsCell.contentsLabel.text = comments[indexPath.row].contents
            }
            
        default:
            break
        }
        return cell
    }
}

extension MovieDetailViewController: UITableViewDelegate {

}
