//
//  RatingStackView.swift
//  MoviePal
//
//  Created by Stephen McMillan on 06/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class RatingStackView: UIStackView {

    static let ratingImage = UIImage(named: "rating")
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func set(rating: Int) {
        
        guard (1...5).contains(rating) else { return }
        
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 1...rating {
            let starView = UIImageView(image: RatingStackView.ratingImage)
            starView.contentMode = .center
            addArrangedSubview(starView)
        }
        
    }

}
