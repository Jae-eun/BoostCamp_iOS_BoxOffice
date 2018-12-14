//
//  MovieInfoTableViewCell.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by 이재은 on 14/12/2018.
//  Copyright © 2018 이재은. All rights reserved.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
}
