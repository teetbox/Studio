//
//  RoundButton.swift
//  Studio
//
//  Created by Matt Tian on 23/01/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    var image: UIImage = #imageLiteral(resourceName: "twitter") {
        didSet {
            setImage(image, for: .normal)
        }
    }
    
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
}
