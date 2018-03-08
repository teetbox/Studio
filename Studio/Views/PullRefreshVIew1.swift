//
//  PullRefreshVIew1.swift
//  Studio
//
//  Created by Matt Tian on 08/03/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class PullRefreshView1: UIViewController {
    
    var dataItems: [String]!
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        dataItems = Array(repeating: "Pull", count: 10)
        
        setupViews()
        setupRefresher()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addConstraints(format: "H:|[v0]|", views: collectionView)
        view.addConstraints(format: "V:|[v0]|", views: collectionView)
    }
    
    func setupRefresher() {
        refresher = UIRefreshControl()
        refresher.tintColor = .red
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.addSubview(refresher)
    }
    
    @objc func handleRefresh() {
        print(#function)
        DispatchQueue.global().async {
            sleep(2)
            self.dataItems = self.dataItems + self.dataItems
            
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        return collection
    }()
    
}

extension PullRefreshView1: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
}
