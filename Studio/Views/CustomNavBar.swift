//
//  CustomNavBar.swift
//  Studio
//
//  Created by Matt Tian on 01/03/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class CustomNavBar: UIViewController {
    
    var imageName: String {
        return "landscape1"
    }
    
    lazy var footprint: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "footprint"), for: .normal)
        button.tintColor = UIColor.fromHEX(string: "#DA7658")
        button.addTarget(self, action: #selector(handleFootprint), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Dismiss button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(handleDismiss))
        
        // Custome navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backfootprint")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backfootprint")
        
        // Custome navigation item title
        guard let customeFont = UIFont(name: "Redressed-Regular", size: 30) else {
            fatalError("Can't find custom font")
        }
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                               NSAttributedStringKey.font: customeFont]

        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = "Fanstastic Journey"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 2, delay: 2, options: [.allowUserInteraction, .autoreverse, .repeat, .curveEaseIn], animations: {
            self.footprint.alpha = 0.4
        })
    }
    
    private func setupViews() {
        let wallpaper = UIImageView(image: UIImage(named: imageName))
        wallpaper.contentMode = .scaleAspectFill
        wallpaper.clipsToBounds = true
        
        view.addSubview(wallpaper)
        view.addConstraints(format: "H:|[v0]|", views: wallpaper)
        view.addConstraints(format: "V:|[v0]|", views: wallpaper)
        
        view.addSubview(footprint)
        view.addConstraints(format: "H:[v0(32)]", views: footprint)
        view.addConstraints(format: "V:[v0(32)]-40-|", views: footprint)
        footprint.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    @objc func handleFootprint() {
        navigationController?.pushViewController(WallpaperView2(), animated: true)
    }
    
}

class WallpaperView2: UIViewController {
    
    var imageName: String {
        return "landscape2"
    }
    
    lazy var footprint: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "footprint"), for: .normal)
        button.tintColor = UIColor.fromHEX(string: "#33506A")
        button.addTarget(self, action: #selector(handleFootprint), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Alone"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, delay: 2, options: [.allowUserInteraction, .autoreverse, .repeat, .curveEaseIn], animations: {
            self.footprint.alpha = 0.4
        })
    }
    
    private func setupViews() {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        view.addConstraints(format: "H:|[v0]|", views: imageView)
        view.addConstraints(format: "V:|[v0]|", views: imageView)
        
        view.addSubview(footprint)
        view.addConstraints(format: "H:[v0(32)]", views: footprint)
        view.addConstraints(format: "V:[v0(32)]-40-|", views: footprint)
        footprint.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func handleFootprint() {
        navigationController?.pushViewController(WallpaperView3(), animated: true)
    }
    
}

class WallpaperView3: WallpaperView2 {
    override var imageName: String { return "landscape3" }
    
    override lazy var footprint: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "footprint"), for: .normal)
        button.tintColor = UIColor.fromHEX(string: "#B95C76")
        button.addTarget(self, action: #selector(handleFootprint), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Alone ME"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Different fonts for navigation title
        setCustomTitle()
    }
    
    func setCustomTitle() {
        let label1 = UILabel()
        label1.text = "Alone"
        label1.font = UIFont(name: "Redressed-Regular", size: 30)
        label1.textColor = .white
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.text = "ME"
        label2.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label2.textColor = .white
        label2.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [label1, label2])
        stackView.axis = .horizontal
        stackView.frame.size.width = label1.frame.width + label2.frame.width
        stackView.frame.size.height = max(label1.frame.height, label2.frame.height)
        
        navigationItem.titleView = stackView
    }
    
    @objc override func handleFootprint() {
        navigationController?.pushViewController(WallpaperView4(), animated: true)
    }
}

class WallpaperView4: WallpaperView2 {
    override var imageName: String { return "landscape4" }
    
    override lazy var footprint: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sunset"
    }
}
