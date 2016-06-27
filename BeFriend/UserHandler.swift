//
//  UserHandler.swift
//  BeFriend
//
//  Created by David Yoo on 6/9/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class User {
    let firstName: String
    let lastName: String
    let username: String
    let password: String
    
    init(firstName: String, lastName: String, username: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
    }
}

class UserHandler {
    
    func saveNewUser(newUser: User) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        
        let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        user.setValue(newUser.firstName, forKey: "firstName")
        user.setValue(newUser.lastName, forKey: "lastName")
        user.setValue(newUser.username, forKey: "username")
        user.setValue(newUser.password, forKey: "password")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchUsers() -> [NSManagedObject] {
        var users = [NSManagedObject]()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            users = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return users
    }
    
    func fetchUser(username: String, password: String) -> User? {
        let users = fetchUsers()
        
        var i = 0
        while i < users.count {
            if users[i].valueForKey("username") as! String == username && users[i].valueForKey("password") as! String == password {
                
                let user = User(firstName: users[i].valueForKey("firstName") as! String, lastName: users[i].valueForKey("lastName") as! String, username: username, password: password)
                
                return user
            }
            i += 1
        }
        
        return nil
    }

}















