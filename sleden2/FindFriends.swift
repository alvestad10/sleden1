//
//  FindFriends.swift
//  sleden2
//
//  Created by Daniel Alvestad on 19/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import Foundation
import Parse


class FindFriends {
    
    // TODO: Få verdiene fra GetFriends slik at denne modellen kan bruke vennene.
    var myFriends: [User] = []
    
    var users: [User] = []
    var usersTable: NSMutableArray {
        
        let usernames = NSMutableArray()
        for user in users {
            if let username = user.username{
                if username != PFUser.currentUser()?.username {
                    usernames.addObject(username)
                    print("henter brukernavn")
                }
            }
        }
        
        return usernames
        
    }
    
    
    var usersIsFriendsTable: NSMutableArray {
        
        let isFriends = NSMutableArray()
        for user in users {
            if let username = user.username{
                if username != PFUser.currentUser()?.username {
                    isFriends.addObject(user.isFriend.rawValue)
                    print("henter brukernavn")
                }
            }
        }
        
        return isFriends
        
    }

    
    
    // Henter brukernavnet fra databasen og plasserer det i en tabell
    func allUsernames(table: UITableView, acnInt: UIActivityIndicatorView){
        acnInt.startAnimating()
        let queryUser = PFUser.query()
        queryUser?.findObjectsInBackgroundWithBlock({ (users: [PFObject]?, error: NSError?) -> Void in
            acnInt.stopAnimating()
            if error == nil {
                if let isUsers = users {
                    for userDB in isUsers {
                        
                        let newUserInArray = User(username: userDB["username"] as! String, userID: userDB.objectId!, isFriend: self.isFriend(userDB["username"] as! String))
                        self.users.append(newUserInArray)
                        print(newUserInArray)
                    }
                    
                }
                
                // Oppdaterer tabellen
                table.reloadData()
                
            }
            
            
            
        })
    }
    
    func isFriend(username: String) -> userRelation {
        
        for friend in self.myFriends {
            
            if friend.username == username {
                return userRelation.Friend
            }
            
        }
        
        return userRelation.notFriends
    }
    

    

    
    
    
    
    
    
    
    
}