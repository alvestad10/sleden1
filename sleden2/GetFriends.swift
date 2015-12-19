//
//  GetFriends.swift
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
    
    
    
    // Henter vennene og legger dem til i myFriends, som kan hentes ut
    func findFriends(table: UITableView, actInt: UIActivityIndicatorView) {
        
        var hasStoppetActivity = false
        
        // TODO: Dårlig kode her; finn ut hvordan man søker i to kolonner på likt i Parse
        
        // Henter først de som er venner med objectID
        let queryFriends1 = PFQuery(className: "Friends")
        let queryFriends2 = PFQuery(className: "Friends")
        queryFriends1.whereKey("user1", equalTo: (PFUser.currentUser()?.objectId)!)
        queryFriends2.whereKey("user2", equalTo: (PFUser.currentUser()?.objectId)!)
        actInt.startAnimating()
        queryFriends1.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print("Found user")
                    
                    // Oppretter en venn i listen myFriends
                    let newFriendsInArray = User(userID: object["user2"] as! String, isFriend: userRelation.Friend)
                    self.myFriends.append(newFriendsInArray)
                    
                    // Henter brukernavnet og plasserer det i tabellen
                    self.findUsername(self.myFriends.count-1, table: table)
                    print(2)
                    
                }
                
                
            } else {
                print(error)
            }
            
            // Sjekker om den andre database queryen er ferdig
            if hasStoppetActivity == true {
                actInt.stopAnimating()
            } else {
                hasStoppetActivity = true
            }
            
        })
        queryFriends2.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    print("Found user")
                    
                    // Oppretter en venn i listen myFriends
                    let newFriendsInArray = User(userID: object["user1"] as! String, isFriend: userRelation.Friend)
                    self.myFriends.append(newFriendsInArray)
                    
                    // Henter brukernavnet og plasserer det i tabellen
                    self.findUsername(self.myFriends.count-1, table: table)
                    print(1)
                }
            } else {
                print(error)
            }
            
            // Sjekker om den andre database queryen er ferdig
            if hasStoppetActivity == true {
                actInt.stopAnimating()
            } else {
                hasStoppetActivity = true
            }
        })
        
    }
    
    // Henter brukernavnet fra databasen og plasserer det i en tabell
    func findUsername(userIndex: Int, table: UITableView){
        
        let queryUser = PFUser.query()
        queryUser?.whereKey("objectId", equalTo: self.myFriends[userIndex].userID)
        queryUser?.findObjectsInBackgroundWithBlock({ (users: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let isUsers = users {
                    for userDB in isUsers {
                        
                        // Oppdaterer myFriends listen sine objekter med brukernavn
                        self.myFriends[userIndex].username = userDB["username"] as? String
                        print(self.myFriends[userIndex].username!)
                    }
                    
                }
                
                // Oppdaterer tabellen
                table.reloadData()
                
            }
            
            
            
        })
        
        
    }
    
    
    
    
    

    
    
}