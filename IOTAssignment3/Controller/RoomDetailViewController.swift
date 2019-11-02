//
//  RoomDetailViewController.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore

// Referred official Firebase documentation from https://firebase.google.com/docs/ios/setup
// Used icons form https://www.flaticon.com/free-icon/studying_501832#term=study%20chair&page=1&position=67
class RoomDetailViewController: UIViewController {
    
    // Setup variables
    var selectedRoomName:String?
    var db:Firestore!
    private var roomDetailList = [RoomDetail]()
    var vacantSeats: Int = 0
    var totalSeats: Int = 0
    
    // IBOutlets
    @IBOutlet weak var chairStatusLabel: UILabel!
    @IBOutlet weak var chairCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup firebase
        db = Firestore.firestore()
        
        // Setup room details
        fetchRoomDetails()
   
    }
    
    private func fetchRoomDetails(){
        db.collection(selectedRoomName!).whereField("chair_status", isGreaterThanOrEqualTo: 0)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        let chairStatus = document.get("chair_status") as! Int
                        let dateValue = document.get("date") as! String
                        let timeValue = document.get("time") as! String
                        
                        let roomDetailModel = RoomDetail(chairStatus: chairStatus, date: dateValue, time: timeValue, roomName: self.selectedRoomName!)
                        if chairStatus == 0{
                            self.vacantSeats+=1
                        }
                        self.roomDetailList.append(roomDetailModel)
                        self.totalSeats = self.roomDetailList.count
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.chairCollectionView.reloadData()
                        self.chairStatusLabel.text = "\(self.vacantSeats)/\(self.totalSeats) Seats Vacant"
                    }
                }
        }
    }
}

extension RoomDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ROOM_CHAIR_IDENTIFIER", for: indexPath as IndexPath) as! ChairCollectionViewCell
        totalSeats+=1
        
        if roomDetailList[indexPath.row].chairStatus == 1{
            // Set the appropriate image of the cell
            cell.roomDetailImageView.image = #imageLiteral(resourceName: "chair_occupied")
        }
        else  {
            // Set the appropriate image of the cell
            vacantSeats+=1
            cell.roomDetailImageView.image = #imageLiteral(resourceName: "chair_vacant")
        }
        
        // Set a corner radius for the view
        cell.layer.cornerRadius = 8
        
        return cell
        
    }
    
    
}


