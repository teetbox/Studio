//
//  RotationButtonVC.swift
//  Studio
//
//  Created by Tong Tian on 1/27/18.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class RotationButton: UIViewController {
    
    var barViewTopConstraint: NSLayoutConstraint!
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fromHEX(string: "#201A1A")
        view.clipsToBounds = true
        view.alpha = 0.6
        return view
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fromHEX(string: "#000000")
        view.layer.cornerRadius = 25.0
        return view
    }()
    
    lazy var collapseButton: RoundButton = {
        let button = RoundButton()
        button.cornerRadius = 25.0
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "collapse"), for: .normal)
        button.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        return button
    }()
    
    let facebookButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        return button
    }()
    
    let twitterButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
        return button
    }()
    
    let instagramButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        return button
    }()
    
    let googleButton: RoundButton = {
        let button = RoundButton()
        button.borderColor = .orange
        button.borderWidth = 1.0
        button.cornerRadius = 25.0
        button.tintColor = .orange
        button.setImage(#imageLiteral(resourceName: "google"), for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(facebookButton)
        stack.addArrangedSubview(twitterButton)
        stack.addArrangedSubview(instagramButton)
        stack.addArrangedSubview(googleButton)
        return stack
    }()
    
    let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Delicious.jpeg")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.fromHEX(string: "#5A4A44")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Bar buttons color
        navigationController?.navigationBar.tintColor = .white
        
        // Bar bottom border line color
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Bar background image
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.backgroundColor = UIColor.brown.withAlphaComponent(0.2)
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.backgroundColor = nil
    }
    
    private func setupViews() {
        view.addSubview(bgImageView)
        view.addConstraints(format: "H:|[v0]|", views: bgImageView)
        view.addConstraints(format: "V:|[v0]|", views: bgImageView)
        
        view.addSubview(barView)
        view.addConstraints(format: "H:|[v0]|", views: barView)
        view.addConstraints(format: "V:[v0(120)]-(-60)-|", views: barView)
        
        barView.addSubview(buttonView)
        barView.addConstraints(format: "H:[v0(44)]", views: buttonView)
        barView.addConstraints(format: "V:|-8-[v0(44)]", views: buttonView)
        buttonView.centerXAnchor.constraint(equalTo: barView.centerXAnchor).isActive = true
        
        barView.addSubview(collapseButton)
        barView.addConstraints(format: "H:[v0(44)]", views: collapseButton)
        barView.addConstraints(format: "V:|-8-[v0(44)]", views: collapseButton)
        collapseButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor).isActive = true
        
        
        barView.addSubview(facebookButton)
        barView.addSubview(twitterButton)
        barView.addSubview(instagramButton)
        barView.addSubview(googleButton)
        barView.addConstraints(format: "H:[v0(44)]", views: facebookButton)
        barView.addConstraints(format: "H:[v0(44)]", views: twitterButton)
        barView.addConstraints(format: "H:[v0(44)]", views: instagramButton)
        barView.addConstraints(format: "H:[v0(44)]", views: googleButton)
        barView.addConstraints(format: "V:[v0(44)]-10-|", views: facebookButton)
        barView.addConstraints(format: "V:[v0(44)]-10-|", views: twitterButton)
        barView.addConstraints(format: "V:[v0(44)]-10-|", views: instagramButton)
        barView.addConstraints(format: "V:[v0(44)]-10-|", views: googleButton)
        
        let width = view.frame.width / 4.0
        let radius = width / 2.0
        facebookButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor, constant: -(width + radius)).isActive = true
        twitterButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor, constant: -radius).isActive = true
        instagramButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor, constant: radius).isActive = true
        googleButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor, constant: width + radius).isActive = true
        
        facebookButton.alpha = 0
        twitterButton.alpha = 0
        instagramButton.alpha = 0
        googleButton.alpha = 0
    }
    
    @objc func toggleMenu(_ sender: UIButton) {
        if buttonView.transform == .identity {
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonView.transform = CGAffineTransform(scaleX: 11.0, y: 11.0)
                self.collapseButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.barView.transform = CGAffineTransform(translationX: 0, y: -60)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5) {
                        self.facebookButton.alpha = 1
                        self.twitterButton.alpha = 1
                        self.instagramButton.alpha = 1
                        self.googleButton.alpha = 1
                    }
                })
            })
        } else {
            UIView.animate(withDuration: 0.5) {
                self.buttonView.transform = .identity
                self.collapseButton.transform = .identity
                self.barView.transform = .identity
                self.facebookButton.alpha = 0
                self.twitterButton.alpha = 0
                self.instagramButton.alpha = 0
                self.googleButton.alpha = 0
            }
        }
    }

}
