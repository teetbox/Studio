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
    
    let demos = ["Basic Animation",         // 0
                 "Image Textfield",         // 1
                 "Rotation Button",         // 2
                 "Spring Animation",        // 3
                 "Pull to Show",            // 4
                 "Show Nav Bar",            // 5
                 "Custom Nav Bar",          // 6
                 "Gradient View",           // 7
                 "Pull Refresh 1",          // 8
                 "Declarative Animation"    // 9
                ]
    
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
            demoViewController = ImageTextfield()
        case 2:
            demoViewController = RotationButton()
        case 3:
            demoViewController = SpringAnimation()
        case 4:
            demoViewController = PullToShow()
        case 5:
            demoViewController = ShowNavBar()
        case 6:
            demoViewController = CustomNavBar()
            let demoNav = UINavigationController(rootViewController: demoViewController)
            
            // Here is a bug from Apple, when present a view from table cell, the first tap doesn't triggle the animation, need another tap.
            // One way to fix it is puts the present code in main queue.
            DispatchQueue.main.async {
                self.present(demoNav, animated: true)
            }
            // Another way is calls CFRunLoopWakeUp.
//            CFRunLoopWakeUp(CFRunLoopGetCurrent())
            return
            
        case 7:
            demoViewController = GradientView()
        case 8:
            demoViewController = PullRefreshView1()
        case 9:
            demoViewController = DeclarativeAnimation()
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

