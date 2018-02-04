//
//  ShowNavBar.swift
//  Studio
//
//  Created by Tong Tian on 2/4/18.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class ShowNavBar: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        collection.scrollIndicatorInsets = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = navigationController?.navigationBar
        // Bar background image
        navBar?.setBackgroundImage(UIImage(), for: .default)
        // Bar bottom border line color
        navBar?.shadowImage = UIImage()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addConstraints(format: "H:|[v0]|", views: collectionView)
        view.addConstraints(format: "V:|[v0]|", views: collectionView)
    }
}

extension ShowNavBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y / 150
        let saturation = offSetY > 1 ? 1 : offSetY
        
        self.navigationController?.navigationBar.tintColor = UIColor(hue: 210.0 / 360.0, saturation: saturation, brightness: 1, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = UIColor(white: 1.0, alpha: saturation)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 1.0, alpha: saturation)
    }
    
}

class CollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Mountain.jpg")
        return view
    }()
    
    func setupViews() {
        addSubview(imageView)
        addConstraints(format: "H:|[v0]|", views: imageView)
        addConstraints(format: "V:|[v0]|", views: imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
