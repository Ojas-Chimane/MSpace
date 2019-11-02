//
//  LoginViewController.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

// Referred official Firebase documentation from https://firebase.google.com/docs/ios/setup
class LoginViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // chio@student.monash.edu - chio1234
    @IBAction func onSignInClick(_ sender: Any) {
        let emailValue = userEmailTextField.text!
        let passwordValue = userPasswordTextField.text!
        
        Auth.auth().signIn(withEmail: emailValue, password: passwordValue) { (user,error) in
            if error == nil{
                self.navigateToHomeScreen()
            }
            else{
                print(error ?? "error")
                print(error?.localizedDescription ?? "error")
                self.presentAlertView()
            }
            
        }
        
    }
    
    
    fileprivate func navigateToHomeScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HOME_STORYBOARD")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    private func presentAlertView(){
        let alert = UIAlertController(title: "Login Error", message: "Please check login credentials and try again!!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Check if user is signed in
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                // User is signed in. Show home screen
                self.navigateToHomeScreen()
            }
        }
        
    }
}
