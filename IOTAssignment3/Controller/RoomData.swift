//
//  Model.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import Foundation

class RoomData{
    var roomName:String?
    var vacancyCount:Int?
        
    init(roomName:String,vacancyCount:Int){
        self.roomName = roomName
        self.vacancyCount = vacancyCount
    }
}

