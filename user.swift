//
//  user.swift
//  sleden2
//
//  Created by Daniel Alvestad on 13/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import Foundation

class User {

    var username: String
    var userID: String
    var isFriend: Bool
    var friendRequest:Bool
    
    
    init(username: String, userID: String, isFriend: Bool, friendRequest: Bool){
        self.username = username
        self.userID = userID
        self.isFriend = isFriend
        self.friendRequest = friendRequest
    }


}
