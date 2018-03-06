//
//  GradientView.swift
//  Studio
//
//  Created by Matt Tian on 06/03/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class GradientView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        setupGradient()
        setupView()
    }
    
    lazy var gradientView: UIView = {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(white: 1.0, alpha: 0.5).cgColor, UIColor.clear.cgColor]
        view.layer.addSublayer(gradientLayer)
        view.backgroundColor = .red
        return view
    }()
    
    func setupView() {
        view.addSubview(gradientView)
        view.addConstraints(format: "H:|[v0]|", views: gradientView)
        view.addConstraints(format: "V:[v0(80)]-20-|", views: gradientView)
    }
    
    func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.green.cgColor, UIColor.clear.cgColor]
        
        view.layer.addSublayer(gradientLayer)
    }
    
}
