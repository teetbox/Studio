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
        
        let dismissButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(handleDismiss))
        
        navigationItem.leftBarButtonItem = dismissButton
        
        // Custome navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
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
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
}
