//
//  MainViewController.swift
//  Studio
//
//  Created by Matt Tian on 23/01/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.separatorColor = .lightGray
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    let details = ["Button Animation", "Image Textfield"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = details[indexPath.row]
        cell.backgroundColor = UIColor.fromHEX(string: "#ABCDEF")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentView: UIView
        
        switch indexPath.row {
        case 0:
            contentView = AnimationView()
        case 1:
            contentView = ImageTextfieldView()
        default:
            return
        }
        
        let detailViewController = DetailViewController()
        detailViewController.contentView = contentView
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

class DetailViewController: UIViewController {
    
    var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(contentView)
        view.addConstraints(format: "H:|[v0]|", views: contentView)
        view.addConstraints(format: "V:|[v0]|", views: contentView)
    }
    
}

