//
//  SignUpViewController.swift
//  BeFriend
//
//  Created by David Yoo on 6/7/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    let userHandler = UserHandler()
    var newUser: User?
    
    enum Error: ErrorType {
        case NoFirstName
        case NoLastName
        case NoUsername
        case NoPassword
        case NoConfirm
        case PasswordMismatch
        case UsernameTaken
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startSession" {
            createAccount()
            if let userPageController = segue.destinationViewController as? UserPageController {
                userPageController.user = newUser
            }
        }
    }

    @IBAction func cancelSignUp() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setup() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            usernameTextField.becomeFirstResponder()
        } else if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func createAccount() {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if noBlankFields() && passwordsMatch() && uniqueUsername() {
            newUser = User(firstName: firstName, lastName: lastName, username: username, password: password)
            userHandler.saveNewUser(newUser!)
        }
    }
    
    func noBlankFields() -> Bool {
        do {
            if firstNameTextField.text == "" {
                throw Error.NoFirstName
            } else if lastNameTextField.text == "" {
                throw Error.NoLastName
            } else if usernameTextField.text == "" {
                throw Error.NoUsername
            } else if passwordTextField.text == "" {
                throw Error.NoPassword
            } else if confirmTextField.text == "" {
                throw Error.NoConfirm
            }
        }
        catch Error.NoFirstName {
            showAlert("First Name Required", viewController: self)
            return false
        } catch Error.NoLastName {
            showAlert("Last Name Required", viewController: self)
            return false
        } catch Error.NoUsername {
            showAlert("Username Required", viewController: self)
            return false
        } catch Error.NoPassword {
            showAlert("Password Required", viewController: self)
            return false
        } catch Error.NoConfirm {
            showAlert("Please Confirm Password", viewController: self)
            return false
        } catch let error {
            fatalError("\(error)")
        }
        
        return true
    }
    
    func passwordsMatch() -> Bool {
        do {
            if passwordTextField.text != confirmTextField.text {
                throw Error.PasswordMismatch
            }
        } catch Error.PasswordMismatch {
            showAlert("Passwords Do Not Match", viewController: self)
            passwordTextField.text = ""
            confirmTextField.text = ""
            return false
        } catch let error {
            fatalError("\(error)")
        }
        return true
    }
    
    func uniqueUsername() -> Bool {
        let users = userHandler.fetchUsers()
        
        do {
            var i = 0
            while i < users.count {
                if users[i].valueForKey("username") as! String == usernameTextField.text! {
                    throw Error.UsernameTaken
                }
                i += 1
            }
        } catch Error.UsernameTaken {
            showAlert("Sorry! Username Already Taken", message: "Please enter another username", viewController: self)
            usernameTextField.text = ""
        } catch let error {
            fatalError("\(error)")
        }
        return true
    }
    
}
