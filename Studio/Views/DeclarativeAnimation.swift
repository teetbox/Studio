//
//  DeclarativeAnimation.swift
//  Studio
//
//  Created by Matt Tian on 13/03/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

public struct Animation {
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let closure: (UIView) -> Void
}

public struct ViewAnimation {
    public let view: UIView
    public let animation: Animation
}

public extension Animation {
    
    static func fadeIn(duration: TimeInterval = 0.3, delay: TimeInterval = 0) -> Animation {
        return Animation(duration: duration, delay: delay, closure: { $0.alpha = 1 })
    }
    
    static func fadeOut(duration: TimeInterval = 0.3, delay: TimeInterval = 0) -> Animation {
        return Animation(duration: duration, delay: delay, closure: { $0.alpha = 0 })
    }
    
    static func resize(to size: CGSize, duration: TimeInterval = 0.3, delay: TimeInterval = 0) -> Animation {
        return Animation(duration: duration, delay: delay, closure: { $0.bounds.size = size })
    }
    
    // move, rotate
}

internal enum AnimationMode {
    case inSequence
    case inParallel
}

public final class AnimationToken {
    
    private let view: UIView
    private let animations: [Animation]
    private let mode: AnimationMode
    private var isValid = true
    
    internal init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }
    
    deinit {
        perform {}
    }
    
    internal func perform(completionHandler: @escaping () -> Void) {
        guard isValid else {
            return
        }
        
        isValid = false
        
        switch mode {
        case .inSequence:
            view.performAnimations(animations, completionHandler: completionHandler)
        case .inParallel:
            view.performAnimationsInParallel(animations, completionHandler: completionHandler)
        }
    }
}

public extension UIView {
    
    @discardableResult
    func animate(_ animations: [Animation]) -> AnimationToken {
        // If all animations have been performed, do return
        /*
         guard !animations.isEmpty else {
         return
         }
         
         var animations = animations
         let animation = animations.removeFirst()
         
         UIView.animate(withDuration: animation.duration, delay: animation.delay, options: UIViewAnimationOptions(), animations: {
         animation.closure(self)
         }, completion: { _ in
         // Recursively perform all animations
         self.animate(animations)
         })
         */
        return AnimationToken(view: self, animations: animations, mode: .inSequence)
    }
    
    @discardableResult
    func animate(inParallel animations: [Animation]) -> AnimationToken {
        /*
        for animation in animations {
            UIView.animate(withDuration: animation.duration, delay: animation.delay, options: UIViewAnimationOptions(), animations: {
                animation.closure(self)
            }, completion: nil)
        }
        */
        return AnimationToken(view: self, animations: animations, mode: .inParallel)
    }
}

internal extension UIView {
    
    func performAnimations(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHandler()
        }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, delay: animation.delay, options: UIViewAnimationOptions(), animations: {
            animation.closure(self)
        }, completion: { _ in
            self.performAnimations(animations, completionHandler: completionHandler)
        })
    }
    
    func performAnimationsInParallel(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHandler()
        }
        
        let animationCount = animations.count
        var completionCount = 0
        
        let animationCompletionHandler = {
            completionCount += 1
            
            if completionCount == animationCount {
                completionHandler()
            }
        }
        
        for animation in animations {
            UIView.animate(withDuration: animation.duration, delay: animation.delay, options: UIViewAnimationOptions(), animations: {
                animation.closure(self)
            }, completion: { _ in
                animationCompletionHandler()
            })
        }
    }
    
}

public func animate(_ tokens: [AnimationToken]) {
    
    guard !tokens.isEmpty else {
        return
    }
    
    var tokens = tokens
    let token = tokens.removeFirst()
    
    token.perform {
        animate(tokens)
    }
}

class DeclarativeAnimation: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performAnimations()
    }
    
    private func setupViews() {
        let views = [firstLabel, secondLabel, thirdLabel, topLeftView]
        views.forEach(view.addSubview)
        
        view.addConstraints(format: "H:|[v0]|", views: firstLabel)
        view.addConstraints(format: "V:[v0(30)]", views: firstLabel)
        firstLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        
        view.addConstraints(format: "H:|[v0]|", views: secondLabel)
        view.addConstraints(format: "V:[v0(30)]", views: secondLabel)
        secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addConstraints(format: "H:|[v0]|", views: thirdLabel)
        view.addConstraints(format: "V:[v0(30)]", views: thirdLabel)
        thirdLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        
        view.addConstraints(format: "H:|[v0]", views: topLeftView)
        view.addConstraints(format: "V:|[v0]", views: topLeftView)
    }
    
    private func performAnimations() {
//        firstLabel.animate([.fadeIn()])
//        secondLabel.animate([.fadeIn(delay: 0.3)])
//        thirdLabel.animate([.fadeIn(delay: 0.6)])
        
        animate([
            firstLabel.animate([
                .fadeIn()
            ]),
            secondLabel.animate([
                .fadeIn()
            ]),
            thirdLabel.animate([
                .fadeIn()
            ])
//            topLeftView.animate(inParallel: [
//                .fadeIn(duration: 1),
//                .resize(to: CGSize(width: 300, height: 300), duration: 3)
//            ])
        ])
        
//        DispatchQueue.global().async {
//            sleep(1)
//            DispatchQueue.main.async {
//                self.view.subviews.forEach { subView in
//                    subView.layer.removeAllAnimations()
//                }
//            }
//        }
        
        let bigAnimation = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
            self.topLeftView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            self.topLeftView.alpha = 1
        }
        
        bigAnimation.startAnimation()
        
        DispatchQueue.global().async {
            sleep(2)
            
            DispatchQueue.main.async {
                // either call stop(true) or stop(false) with finish(at:) together
                
//                bigAnimation.stopAnimation(true)
                
                
                bigAnimation.stopAnimation(false)
                bigAnimation.finishAnimation(at: .start)
            }
        }
        
    }
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Hello Matt"
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.alpha = 0
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Welcome to the Swift world"
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.alpha = 0
        return label
    }()
    
    let thirdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Please enjoy it"
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.alpha = 0
        return label
    }()
    
    let topLeftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.clipsToBounds = true
        view.backgroundColor = .green
        view.alpha = 0
        return view
    }()
    
}
