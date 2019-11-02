//
//  RoomsViewController.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseCore

// Referred official Firebase documentation from https://firebase.google.com/docs/ios/setup
class RoomsViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var roomTableView: UITableView!
    @IBOutlet weak var roomSearchBar: UISearchBar!
    
    // Setup variables
    private var roomList = [RoomData]()
    private var filteredRoomList = [RoomData]()
    var db:Firestore!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup firebase
        db = Firestore.firestore()
        
        // Setup listener for changes in the rooms
        self.listenForChangesInRoomVacancies()
        
        // Setup the data on screen
        fetchStudySpacesList { response in
            print(response)
            
            self.roomList.append(response)
            self.roomList = self.roomList.sorted(by:{ $0.roomName! < $1.roomName! })
            self.filteredRoomList = self.roomList
            
            // Reload the table on the main thread
            DispatchQueue.main.async {
                self.roomTableView.reloadData()
            }
        }
        
        // Remove unwanted table view lines
        roomTableView.tableFooterView = UIView()
        
    }
    
    // Dismiss on screen keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.roomSearchBar.endEditing(true)
    }
    
    private func fetchStudySpacesList(completion: @escaping (_ roomObj: RoomData) -> Void) {
        db.collection("study-spaces").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    self.showVacancyCount(roomName: document.documentID){ roomObject in
                        completion(roomObject)
                    }
                }
            }
        }
    }
    
    
    private func fetchStudySpaceIds(completion: @escaping (_ roomNames: [String]) -> Void){
        var roomIdList = [String]()
        db.collection("study-spaces").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    roomIdList.append(document.documentID)
                }
                completion(roomIdList)
            }
        }
    }
    
    
    private func showVacancyCount(roomName:String, completion: @escaping (_ count: RoomData) -> Void){
        
        db.collection(roomName).whereField("chair_status", isLessThanOrEqualTo: 0)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var vacancyCount = 0
                    for _ in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        vacancyCount+=1;
                    }
                    completion(RoomData(roomName: roomName, vacancyCount: vacancyCount))
                }
                
        }
    }
    
    private func listenForChangesInRoomVacancies() {
        
        fetchStudySpaceIds { roomIds in
                        
            for room in roomIds {
                self.db.collection(room)
                    .addSnapshotListener { querySnapshot, error in
                        guard let snapshot = querySnapshot else {
                            print("Error fetching snapshots: \(error!)")
                            return
                        }
                        snapshot.documentChanges.forEach { diff in
                            if (diff.type == .added) { }
                            if (diff.type == .modified) {
                                print("Modified Room Data: \(diff.document.data())")
                                print("ROOM ID ##: \(room)")
                                self.roomList.removeAll()
                                
                                self.fetchStudySpacesList { response in
                                    print(response)
                                    self.roomList.append(response)
                                    self.roomList = self.roomList.sorted(by:{ $0.roomName! < $1.roomName! })
                                    self.filteredRoomList = self.roomList
                                    
                                    DispatchQueue.main.async {
                                        self.roomTableView.reloadData()
                                    }
                                    
                                }
                            }
                            if (diff.type == .removed) {
                                print("Removed Room Data: \(diff.document.data())")
                            }
                        }
                }
            }
            
        }
        
    }
    
    // Pass the selected room id to the detail controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RoomDetailViewController {
            if(sender != nil){
                viewController.selectedRoomName = sender as? String
            }
        }
    }
    
}

// Setup Room Table View
extension RoomsViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ROOMS_CELL_IDENTIFIER", for: indexPath) as! RoomsTableViewCell
        
        cell.roomNameLabel.text = filteredRoomList[indexPath.row].roomName!
        cell.vacantSeatsLabel.text = "\(String(filteredRoomList[indexPath.row].vacancyCount!))"
        if filteredRoomList[indexPath.row].vacancyCount! == 0 {
            cell.statusColorView.backgroundColor = .red
        }
        else{
            cell.statusColorView.backgroundColor = .green
        }
        return cell
    }
    
    // Navigate to room detail screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ROOM_DETAIL_SEGUE", sender: filteredRoomList[indexPath.row].roomName)
    }
    
    
}

// Search for the data in the locationList and add it to filteredLocationList
extension RoomsViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Searched textDidChange Results: ", searchBar.text ?? "hello")
        if let searchText = searchBar.text, searchText.count > 0 {
            filteredRoomList = roomList.filter({(room: RoomData) -> Bool in
                return (room.roomName?.contains(searchText))!})
        }
        else {
            filteredRoomList = roomList
            
        }
        roomTableView.reloadData()
    }
}

