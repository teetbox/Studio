//
//  ScrollView.swift
//  Studio
//
//  Created by Matt Tian on 15/03/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class ScrollView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        setupViews()
    }
    
    @objc func backHandler() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        
//        scrollView.addSubview(backImage)
//        scrollView.addConstraints(format: "H:|[v0]|", views: backImage)
//        scrollView.addConstraints(format: "V:|[v0(60)]", views: backImage)
        
        view.addSubview(backButton)
        view.addConstraints(format: "H:|-15-[v0(32)]", views: backButton)
        view.addConstraints(format: "V:|-30-[v0(32)]", views: backButton)
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 300)
        scrollView.backgroundColor = .lightGray
        return scrollView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backHandler), for: .touchUpInside)
        return button
    }()
    
    let backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wwdc")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
}
