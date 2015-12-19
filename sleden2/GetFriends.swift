//
//  getFriends.swift
//  sleden2
//
//  Created by Daniel Alvestad on 19/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import Foundation
import Parse




class GetFriends {
    
    var myFriends: NSMutableArray
    
    
    init() {
        self.myFriends = NSMutableArray()
    }
    
    
    
    
    func findFriends() {
        
        // Make call to user tabel i database and fetch friends
        let queryFriends = PFQuery(className: "Friends")
        queryFriends.whereKey("user1", equalTo: (PFUser.currentUser()?.objectId)!)
        queryFriends.whereKey("user2", equalTo: (PFUser.currentUser()?.objectId)!)
        queryFriends.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    
                    if (object["user1"] as? String == PFUser.currentUser()?.objectId){
                        
                        let newFriendsInArray = User(userID: object["user2"] as! String, isFriend: userRelation.Friend)
                        self.myFriends.addObject(newFriendsInArray as! AnyObject)
                        print(2)
                    } else {
                        let newFriendsInArray = User(userID: object["user1"] as! String, isFriend: userRelation.Friend)
                        self.myFriends.addObject(newFriendsInArray as! AnyObject)
                        print(1)
                    }
                    
                }
                
            } else {
                print(error)
            }
        })
    }
}
