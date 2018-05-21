//
//  MenuBarCollection.swift
//  Studio
//
//  Created by Matt Tian on 14/03/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

// MARK: - Menu Bar

class MenuBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var parentVC: MenuBarCollection?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.fromHEX(string: "#E8E8E8")
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parentVC?.scrollToMenu(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    private func setupViews() {
        let subViews = [menuCollection, menuBar]
        subViews.forEach(addSubview)
        
        addConstraints(format: "H:|[v0]|", views: menuCollection)
        addConstraints(format: "V:|[v0]|", views: menuCollection)
        addConstraints(format: "V:[v0(4)]|", views: menuBar)
        
        let width = UIScreen.main.bounds.width
        let oneThird = width / 6
        let oneFourth = width / 4
        menuBarCenterConstraint = menuBar.centerXAnchor.constraint(equalTo: leftAnchor)
        menuBarCenterConstraint?.isActive = true
        menuBarCenterConstraint?.constant = oneThird * 1
        menuBar.widthAnchor.constraint(equalToConstant: oneFourth).isActive = true
    }
    
    let cellId = "Cell"
    lazy var menuCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        return collection
    }()
    
    var menuBarCenterConstraint: NSLayoutConstraint?
    let menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
}

class MenuCell: UICollectionViewCell {
    
}

// MARK: - Main View

class MenuBarCollection: UIViewController {
    
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
//        backScrollView.contentSize = view.bounds.size
//        view.addSubview(backScrollView)
//        view.addConstraints(format: "H:|[v0]|", views: backScrollView)
//        view.addConstraints(format: "V:|[v0]|", views: backScrollView)

        view.addSubview(backButton)
        view.addConstraints(format: "H:|-15-[v0(32)]", views: backButton)
        view.addConstraints(format: "V:|-30-[v0(32)]", views: backButton)
        
        view.addSubview(topView)
        view.addConstraints(format: "H:|[v0]|", views: topView)
        view.addConstraints(format: "V:|[v0(200)]", views: topView)
        
        view.addSubview(backImage)
        view.addConstraints(format: "H:|[v0]|", views: backImage)
        view.addConstraints(format: "V:|-(-25)-[v0]", views: backImage)
        backImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50).isActive = true
        
        view.addSubview(menuView)
        view.addConstraints(format: "H:|[v0]|", views: menuView)
        view.addConstraints(format: "V:[v0(100)]", views: menuView)
        menuView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        menuView.parentVC = self
        
        view.addSubview(contentView)
        view.addConstraints(format: "H:|[v0]|", views: contentView)
        view.addConstraints(format: "V:[v0]|", views: contentView)
        contentView.topAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
        
        view.bringSubview(toFront: backButton)
    }
    
    let backScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        return scrollView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backHandler), for: .touchUpInside)
        return button
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fromHEX(string: "#ABCDEF")
        return view
    }()
    
    let backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wwdc")
        return imageView
    }()
    
    let menuView: MenuBarView = {
        let view = MenuBarView()
        return view
    }()
    
    let cellId = "Cell"
    lazy var contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ContentCell.self, forCellWithReuseIdentifier: cellId)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.bounces = false
        return collection
    }()
    
}

class ContentCell: UICollectionViewCell {
    
}

extension MenuBarCollection: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContentCell
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = UIScreen.main.bounds.width
        let position = scrollView.contentOffset.x
        menuView.menuBarCenterConstraint?.constant = position / 3 + width / 6
    }
    
    func scrollToMenu(at index: Int) {
        contentView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
    }
    
}
