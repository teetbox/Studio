//
//  MainViewController.swift
//  Studio
//
//  Created by Matt Tian on 23/01/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.separatorColor = .lightGray
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    let demos = ["Basic Animation", "Image Textfield", "Rotation Button", "Spring Animation"]
    
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
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = demos[indexPath.row]
        cell.backgroundColor = UIColor.fromHEX(string: "#ABCDEF")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let detailVC = DetailVC()
            detailVC.contentView = AnimationView()
            navigationController?.pushViewController(detailVC, animated: true)
            return
        }
        
        let demoViewController: UIViewController
        switch indexPath.row {
        case 1:
            demoViewController = ImageTextfieldVC()
        case 2:
            demoViewController = RotationButtonVC()
        case 3:
            demoViewController = SpringAnimationVC()
        default:
            preconditionFailure("No display handler for demo: \(demos[indexPath.row]).")
        }
        navigationController?.pushViewController(demoViewController, animated: true)
    }
    
}

class DetailVC: UIViewController {
    
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

