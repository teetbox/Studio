//
//  PullToShow.swift
//  Studio
//
//  Created by Tong Tian on 2/3/18.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class PullToShow: UIViewController {
    
    let playView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    let navView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fromHEX(string: "#273B5E")
        return view
    }()
    
    lazy var whereButton: UIButton = {
        let button = UIButton()
        button.setTitle("Where", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleWhere), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    var previousOffSetY: CGFloat = 0
    var counter = 0
    var initialCenter = CGPoint()
    var previousCenter = CGPoint()
    var isPlayDisplayed = false
    var playViewBottomConstraint: NSLayoutConstraint? {
        didSet {
            print(playViewBottomConstraint?.constant)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initialCenter = playView.center
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    func setUpViews() {
        view.addSubview(navView)
        view.addConstraints(format: "H:|[v0]|", views: navView)
        view.addConstraints(format: "V:|[v0(120)]", views: navView)
        
        navView.addSubview(backButton)
        navView.addConstraints(format: "H:|-15-[v0(60)]", views: backButton)
        navView.addConstraints(format: "V:[v0(30)]-15-|", views: backButton)
        
        view.addSubview(playView)
        playView.alpha = 0.5
        view.addConstraints(format: "H:|[v0]|", views: playView)
        view.addConstraints(format: "V:[v0(400)]", views: playView)
        playView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playViewBottomConstraint = playView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -60)
        playViewBottomConstraint?.isActive = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        playView.addGestureRecognizer(panGesture)
        
        view.addSubview(whereButton)
        view.addConstraints(format: "H:[v0(60)]-15-|", views: whereButton)
        view.addConstraints(format: "V:|-20-[v0(30)]", views: whereButton)
        
        view.bringSubview(toFront: navView)
        view.bringSubview(toFront: playView)
        view.bringSubview(toFront: whereButton)
    }
    
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleWhere() {
        print(#function)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer : UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else {
            return
        }
        let panView = gestureRecognizer.view!
        
        let translation = gestureRecognizer.translation(in: panView.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            previousCenter = panView.center
            print("Begin")
            view.bringSubview(toFront: playView)
        }
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: previousCenter.x, y: previousCenter.y + translation.y)
            panView.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            panView.center = previousCenter
        }
        
        if gestureRecognizer.state == .ended {
            let distance = panView.center.y - initialCenter.y
            
            if isPlayDisplayed {
                if previousCenter.y - panView.center.y > 20 {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.initialCenter
                    }, completion: { (true) in
                        self.isPlayDisplayed = false
                        print("4")
                        self.view.bringSubview(toFront: self.whereButton)
                    })
                } else {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.view.center
                    }, completion: { (true) in
                        self.isPlayDisplayed = true
                        print("3")
                    })
                }
            } else {
                if distance > 50 {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.view.center
                    }, completion: { (true) in
                        self.isPlayDisplayed = true
                        print("1")
                    })
                } else {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.initialCenter
                    }, completion: { (true) in
                        self.isPlayDisplayed = false
                        print("2")
                    })
                }
                
                self.previousCenter = panView.center
            }
        }
    }
    
}
