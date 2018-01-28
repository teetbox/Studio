//
//  AnimationView.swift
//  Studio
//
//  Created by Matt Tian on 23/01/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    
    let forwardButton: RoundButton = {
        let button = RoundButton()
        button.cornerRadius = 25.0
        button.tintColor = UIColor.cyan
        button.setImage(#imageLiteral(resourceName: "forward"), for: .normal)
        return button
    }()
    
    let facebookButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    let twitterButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    let instagramButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    let googleButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "google"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    var googleCenter: CGPoint!
    var facebookCenter: CGPoint!
    var twitterCenter: CGPoint!
    var instagramCenter: CGPoint!
    
    var isSharing = false
    var isViewDidLoad = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.gray.cgColor]
        layer.addSublayer(gradientLayer)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(googleButton)
        addSubview(googleButton)
        addConstraints(format: "H:[v0(50)]", views: googleButton)
        addConstraints(format: "V:[v0(50)]-90-|", views: googleButton)
        googleButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(twitterButton)
        addConstraints(format: "H:[v0(50)]", views: twitterButton)
        addConstraints(format: "V:[v0(50)]-20-|", views: twitterButton)
        twitterButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(facebookButton)
        addConstraints(format: "H:[v0(50)]", views: facebookButton)
        addConstraints(format: "V:[v0(50)]-20-|", views: facebookButton)
        facebookButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80).isActive = true
        
        addSubview(instagramButton)
        addConstraints(format: "H:[v0(50)]", views: instagramButton)
        addConstraints(format: "V:[v0(50)]-20-|", views: instagramButton)
        instagramButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80).isActive = true
        
        addSubview(forwardButton)
        addConstraints(format: "H:[v0(50)]", views: forwardButton)
        addConstraints(format: "V:[v0(50)]-150-|", views: forwardButton)
        forwardButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        forwardButton.addTarget(self, action: #selector(toggleShareButton), for: .touchUpInside)
    }
    
    @objc func toggleShareButton() {
        if !isViewDidLoad {
            googleCenter = googleButton.center
            facebookCenter = facebookButton.center
            twitterCenter = twitterButton.center
            instagramCenter = instagramButton.center
            
            googleButton.center = forwardButton.center
            facebookButton.center = forwardButton.center
            twitterButton.center = forwardButton.center
            instagramButton.center = forwardButton.center
            
            isViewDidLoad = true
        }
        
        if isSharing {
            UIView.animate(withDuration: 0.3) {
                self.googleButton.center = self.forwardButton.center
                self.googleButton.alpha = 0
                self.facebookButton.center = self.forwardButton.center
                self.facebookButton.alpha = 0
                self.instagramButton.center = self.forwardButton.center
                self.instagramButton.alpha = 0
                self.twitterButton.center = self.forwardButton.center
                self.twitterButton.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.googleButton.center = self.googleCenter
                self.googleButton.alpha = 1
                self.facebookButton.center = self.facebookCenter
                self.facebookButton.alpha = 1
                self.instagramButton.center = self.instagramCenter
                self.instagramButton.alpha = 1
                self.twitterButton.center = self.twitterCenter
                self.twitterButton.alpha = 1
            }
        }
        
        isSharing = !isSharing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
