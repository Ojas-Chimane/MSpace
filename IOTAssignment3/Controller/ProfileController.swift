//
//  ProfileViewController.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

// Referred official Firebase documentation from https://firebase.google.com/docs/ios/setup
class ProfileController: UITableViewController {
    
    // IBOutlets
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileIdLabel: UILabel!
    @IBOutlet weak var profileCourseNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    
    // DB reference variable
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup DB reference
        ref = Database.database().reference()
        
        // Fetch the logged in user ID
        let userID = Auth.auth().currentUser?.uid
        print(userID!)
        
        loadUserProfileDetails(userID: userID!)
        
        // Remove unwanted table view lines
        profileTableView.tableFooterView = UIView()
    }
    
    
    func loadUserProfileDetails(userID: String){
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let userName = value?["full_name"] as? String ?? ""
            let courseName = value?["course_name"] as? String ?? ""
            let studentId = value?["student_id"] as? String ?? ""
            let userEmail = Auth.auth().currentUser?.email as? String ?? ""
            
            print("Details: \(userName),\(courseName),\(studentId) , userEmail)")
            
            self.profileNameLabel.text = userName
            self.profileIdLabel.text = studentId
            self.profileEmailLabel.text = userEmail
            self.profileCourseNameLabel.text = courseName
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    fileprivate func navigateToLoginScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LOGIN_STORYBOARD")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func userLogoutBtnPressed(_ sender: Any) {
        //Firebase Reference: https://firebase.google.com/docs/auth/ios/custom-auth
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigateToLoginScreen()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
