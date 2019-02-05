//
//  SpeechBubbleButton.swift
//  MoviePal
//
//  Created by Stephen McMillan on 05/02/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit

class SpeechBubbleButton: UIButton {
    var isConfigured: Bool = false {
        didSet {
            if isConfigured {
                self.setBackgroundImage(UIImage(named: "bubble-selected"), for: .normal)
            } else {
                setBackgroundImage(UIImage(named: "bubble-empty"), for: .normal)
            }
        }
    }
}
