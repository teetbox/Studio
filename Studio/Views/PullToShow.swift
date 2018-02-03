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
    
    @objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else {
            return
        }
        let panView = gestureRecognizer.view!
        
        //        if (panView.center.x != initialCenter.x) {
        //            panView.center.x = initialCenter.x
        //            return
        //        }
        
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
    
    
    func setUpViews() {
        view.addSubview(navView)
        view.addConstraints(format: "H:|[v0]|", views: navView)
        view.addConstraints(format: "V:|[v0(60)]", views: navView)
        
        view.addSubview(playView)
        view.addConstraints(format: "H:|[v0]|", views: playView)
        view.addConstraints(format: "V:[v0(400)]", views: playView)
        playView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playViewBottomConstraint = playView.bottomAnchor.constraint(equalTo: navView.bottomAnchor)
        playViewBottomConstraint?.isActive = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panPiece))
        playView.addGestureRecognizer(panGesture)

        view.bringSubview(toFront: navView)
        view.bringSubview(toFront: playView)
    }
    
    
}

extension PullToShow: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let panGesture = gestureRecognizer as! UIPanGestureRecognizer
        let velocity = panGesture.velocity(in: panGesture.view?.superview)
        print(velocity)
        return fabs(velocity.y) > fabs(velocity.x)
    }
}
