//
//  MovieDetailController.swift
//  MoviePal
//
//  Created by Stephen McMillan on 06/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    // Outlets
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var ratingView: RatingStackView!
    
    // The Movie that is the subject of the detail view.
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        guard let movie = movie else {
            return
        }
        
        titleLabel.text = movie.originalTitle
        releaseDateLabel.text = String(movie.releaseDate.prefix(4))
        overviewLabel.text = movie.overview
        
        ratingView.set(rating: Int(movie.voteAverage/2)) // The value returned is out of 10 but I want the value out of 5.
    }

}
