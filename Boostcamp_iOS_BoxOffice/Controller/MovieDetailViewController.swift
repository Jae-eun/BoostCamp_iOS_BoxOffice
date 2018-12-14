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
    
    var comments: [Comments] = []
    var cellIdentifier: String = "MovieInfoCell"
    var movieId: String = ""
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellIdentifier == "CommentCell" {
            return comments.count
        } else {
            return 0
        }
    }
    
    //    let weak var userImage: UIImageView!
    //    @IBOutlet weak var nickNameLabel: UILabel!
    //    @IBOutlet weak var creationTimeLabel: UILabel!
    //    @IBOutlet weak var commentLabel: UILabel!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        
        let comment: Comments = self.comments[indexPath.row]
        
        cell.nickNameLabel.text = comment.writer
        cell.creationTimeLabel.text = String(comment.timestamp)
        cell.commentLabel.text = comment.contents
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
