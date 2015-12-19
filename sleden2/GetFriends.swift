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
    
    var myFriends: [User] = []
    var myFriendsTable: NSMutableArray {
        
        let usernames = NSMutableArray()
        for friend in myFriends {
            if let username = friend.username {
                usernames.addObject(username)
            }
        }
        return usernames
        
    }
    
    
    
    
    func findFriends(view: myFrindsViewController) {
        
        // Make call to user tabel i database and fetch friends
        let queryFriends1 = PFQuery(className: "Friends")
        let queryFriends2 = PFQuery(className: "Friends")
        queryFriends1.whereKey("user1", equalTo: (PFUser.currentUser()?.objectId)!)
        queryFriends2.whereKey("user2", equalTo: (PFUser.currentUser()?.objectId)!)
        
        queryFriends1.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print("Found user")
                    let newFriendsInArray = User(userID: object["user2"] as! String, isFriend: userRelation.Friend)
                    self.myFriends.append(newFriendsInArray)
                    self.findUsername(self.myFriends.count-1, view: view)
                    print(2)
                    
                }
                
                
            } else {
                print(error)
            }
        })
        queryFriends2.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print("Found user")
                    let newFriendsInArray = User(userID: object["user1"] as! String, isFriend: userRelation.Friend)
                    self.myFriends.append(newFriendsInArray)
                    self.findUsername(self.myFriends.count-1, view: view)
                    print(2)
                    
                }
                
                
            } else {
                print(error)
            }
        })

    }
    
    
    func findUsername(userIndex: Int, view: myFrindsViewController){
        
        let queryUser = PFUser.query()
        queryUser?.whereKey("objectId", equalTo: self.myFriends[userIndex].userID)
        queryUser?.findObjectsInBackgroundWithBlock({ (users: [PFObject]?, error: NSError?) -> Void in
            
            
            if error == nil {
                
                if let isUsers = users {
                    for userDB in isUsers {
                        self.myFriends[userIndex].username = userDB["username"] as? String
                        print(self.myFriends[userIndex].username!)
                    }
                    
                }
                view.updateTableFromModule()
                
            }
            
            
            
        })
        
        
    }
    
    
    
    
    
    
    
}
