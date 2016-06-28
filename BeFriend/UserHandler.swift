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
    let interest1, interest2, interest3: String
    
    init(firstName: String, lastName: String, username: String, password: String, interests: [String]) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
        self.interest1 = interests[0]
        self.interest2 = interests[1]
        self.interest3 = interests[2]
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
        user.setValue(newUser.interest1, forKey: "interest1")
        user.setValue(newUser.interest2, forKey: "interest2")
        user.setValue(newUser.interest3, forKey: "interest3")
        
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
                
                let interest1 = users[i].valueForKey("interest1") as! String
                let interest2 = users[i].valueForKey("interest2") as! String
                let interest3 = users[i].valueForKey("interest3") as! String
                
                let interests = [interest1, interest2, interest3]
                
                let user = User(firstName: users[i].valueForKey("firstName") as! String, lastName: users[i].valueForKey("lastName") as! String, username: username, password: password, interests: interests)
                
                return user
            }
            i += 1
        }
        
        return nil
    }

}















