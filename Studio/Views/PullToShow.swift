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
    var playViewBottomConstraint: NSLayoutConstraint?

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
        view.addConstraints(format: "H:|[v0]|", views: playView)
        view.addConstraints(format: "V:[v0(400)]", views: playView)
        playView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playViewBottomConstraint = playView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -60)
        playViewBottomConstraint?.isActive = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        playView.addGestureRecognizer(panGesture)
        
        view.bringSubview(toFront: navView)
        view.bringSubview(toFront: playView)
    }
    
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
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
                    })
                } else {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.view.center
                    }, completion: { (true) in
                        self.isPlayDisplayed = true
                    })
                }
            } else {
                if distance > 50 {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.view.center
                    }, completion: { (true) in
                        self.isPlayDisplayed = true
                    })
                } else {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.playView.center = self.initialCenter
                    }, completion: { (true) in
                        self.isPlayDisplayed = false
                    })
                }
                
                self.previousCenter = panView.center
            }
        }
    }
    
}
