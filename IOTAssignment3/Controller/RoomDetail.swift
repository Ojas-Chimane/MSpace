//
//  Room.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import Foundation

class RoomDetail{
    var chairStatus:Int?
    var date:String?
    var time:String?
    var roomName:String?
    
    init(chairStatus:Int,date:String,time:String,roomName:String){
        self.chairStatus = chairStatus
        self.date = date
        self.time = time
        self.roomName = roomName
    }
}
