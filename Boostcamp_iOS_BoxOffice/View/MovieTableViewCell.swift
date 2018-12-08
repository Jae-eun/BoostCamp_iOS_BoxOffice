//
//  MovieTableViewCell.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 08/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieInfoLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = UIImage(named: "img_placeholder")
    }
}
