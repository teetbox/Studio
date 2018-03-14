//
//  ImageTextfieldVC.swift
//  Studio
//
//  Created by Matt Tian on 23/01/2018.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

class ImageTextfield: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        
        setupViews()
    }
    
    private func setupViews() {
        let views = [usernameText, usernameLine, passwordText, passwordLine, profileImage]
        views.forEach(view.addSubview)
        
        view.addConstraints(format: "H:|-40-[v0]-40-|", views: usernameText)
        view.addConstraints(format: "H:|-40-[v0]-40-|", views: usernameLine)
        view.addConstraints(format: "V:[v0(40)][v1(0.7)]", views: usernameText, usernameLine)
        usernameText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addConstraints(format: "H:|-40-[v0]-40-|", views: passwordText)
        view.addConstraints(format: "H:|-40-[v0]-40-|", views: passwordLine)
        view.addConstraints(format: "V:[v0(40)][v1(0.7)]", views: passwordText, passwordLine)
        passwordText.centerYAnchor.constraint(equalTo: usernameText.centerYAnchor, constant: 60).isActive = true
     
        view.addConstraints(format: "H:|-20-[v0]-20-|", views: profileImage)
        view.addConstraints(format: "V:[v0(200)]-20-|", views: profileImage)
    }
    
    let usernameText: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        let userIcon = UIImageView(frame: CGRect(x: 5, y: 0, width: 24, height: 24))
        userIcon.image = UIImage(named: "user")
        userIcon.contentMode = .scaleAspectFit
        userIcon.tintColor = .white
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 24))
        iconView.addSubview(userIcon)
        textField.leftViewMode = .always
        textField.leftView = iconView
        return textField
    }()
    
    let usernameLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let passwordText: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        let passwordIcon = UIImageView(frame: CGRect(x: 5, y: 0, width: 24, height: 24))
        passwordIcon.image = UIImage(named: "password")
        passwordIcon.contentMode = .scaleAspectFit
        passwordIcon.tintColor = .white
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 24))
        iconView.addSubview(passwordIcon)
        textField.leftViewMode = .always
        textField.leftView = iconView
        return textField
    }()
    
    let passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7900")
        imageView.contentMode = .scaleAspectFit

        // .scaleToFill by Default
        // .scaleAspectFit - show full image, extra area show transparent
        // .scaleAspectFill - show image in full area, extra image go out of bounds. If set clipsToBounds to true, extre image hide
        return imageView
    }()
    
}
