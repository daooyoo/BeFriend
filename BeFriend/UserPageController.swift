//
//  UserPageController.swift
//  BeFriend
//
//  Created by David Yoo on 6/12/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

class UserPageController: UIViewController {
    
    var user: User!
    
    let profilePic = UIImageView()
    let welcomeLabel = UILabel()
    let infolabel = UILabel()
    //var infoTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 234/255, green: 208/255, blue: 45/255, alpha: 1.0)
        welcomeLabel.text = "Welcome, \(user.firstName)!"
        profilePic.backgroundColor = .blueColor()
        infolabel.text = "\(user.firstName) \(user.lastName)"
        infolabel.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            welcomeLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            welcomeLabel.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 20)])
        
        view.addSubview(profilePic)
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            profilePic.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            profilePic.widthAnchor.constraintEqualToConstant(150),
            profilePic.heightAnchor.constraintEqualToConstant(150),
            profilePic.topAnchor.constraintEqualToAnchor(welcomeLabel.bottomAnchor, constant: 20)])
        
        view.addSubview(infolabel)
        infolabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            infolabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            infolabel.topAnchor.constraintEqualToAnchor(profilePic.bottomAnchor, constant: 20)])
        
//        view.addSubview(infoTable)
//        infoTable.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activateConstraints([
//            infoTable.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 20),
//            infoTable.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -20),
//            infoTable.topAnchor.constraintEqualToAnchor(profilePic.bottomAnchor, constant: 20),
//            infoTable.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20)])
        
    }
    
}

















