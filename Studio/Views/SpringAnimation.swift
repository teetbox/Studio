//
//  SpringAnimationVC.swift
//  Studio
//
//  Created by Tong Tian on 2/1/18.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class SpringAnimation: UIViewController {
    
    var originalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        
        alertView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originalCenter = alertView.center
    }
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Show", for: .normal)
        button.addTarget(self, action: #selector(showTouched), for: .touchUpInside)
        return button
    }()
    
    lazy var springButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Spring", for: .normal)
        button.addTarget(self, action: #selector(springTouched), for: .touchUpInside)
        return button
    }()
    
    private func setupViews() {
        view.addSubview(alertView)
        view.addConstraints(format: "H:[v0(200)]", views: alertView)
        view.addConstraints(format: "V:[v0(150)]", views: alertView)
        alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        [showButton, springButton].forEach { view.addSubview($0) }
        view.addConstraints(format: "H:|[v0]|", views: showButton)
        view.addConstraints(format: "H:|[v0]|", views: springButton)
        view.addConstraints(format: "V:[v0(50)][v1(50)]|", views: showButton, springButton)
    }
    
    @objc func showTouched() {
        alertView.transform = CGAffineTransform(scaleX: 0.3, y: 2)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.alertView.transform = .identity
            self.alertView.alpha = 1
        }, completion: nil)
    }
    
    @objc func springTouched() {
        alertView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        alertView.center.y = alertView.center.y - (alertView.frame.height / 2)
        alertView.transform = CGAffineTransform(rotationAngle: 1.5)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.alertView.transform = .identity
            self.alertView.alpha = 1
        }, completion: { (true) in
            self.alertView.center = self.originalCenter
            self.alertView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        })
    }
    
}
