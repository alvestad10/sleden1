//
//  userRelationEnum.swift
//  sleden2
//
//  Created by Daniel Alvestad on 19/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import Foundation


enum userRelation: String {
    case Friend = "Friend",
        SendtFriendRequest = "Freind Request Pending",
        RecivedFriendRequest = "Friend Request Recived",
        notFriends = "Not Friend"
    
    // Muligheter for funksjoner
    func acceptFriendRequest() {
        print("Friend request accepted")
    }
    
    func declineFriendRequest() {
        print("Friend request declined")
    }
}

struct User {
    
    var username: String?
    var userID: String
    var isFriend: userRelation
    
    init(username: String, userID: String, isFriend: userRelation){
        self.username = username
        self.userID = userID
        self.isFriend = isFriend
    }
    
    init(userID: String, isFriend: userRelation) {
        self.username = nil
        self.userID = userID
        self.isFriend = isFriend
        
    }
}