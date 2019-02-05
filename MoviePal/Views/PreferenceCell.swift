//
//  PreferenceCell.swift
//  MoviePal
//
//  Created by Stephen McMillan on 04/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class PreferenceCell: UITableViewCell {

    static let reuseIdentifier = "PreferenceCell"
    private let checkedImage = UIImage(named: "checkmark_selected")
    private let uncheckedImage = UIImage(named: "checkmark")
    
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var preferenceDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        checkmarkImageView.image = selected ? checkedImage : uncheckedImage
    }

    

}
