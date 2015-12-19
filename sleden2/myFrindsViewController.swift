//
//  myFrindsViewController.swift
//  sleden2
//
//  Created by Daniel Alvestad on 12/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit
import Parse


class myFrindsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var friendsTable: UITableView!
    
    var myFriends: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        findFriends()
        
        self.friendsTable.reloadData()
        
        
    }
    
    enum userRelation {
        case Friend, SendtFriendRequest, RecivedFriendRequest, notFriends
        
        // Muligheter for funksjoner
        func acceptFriendRequest() {
            print("Friend request accepted")
        }
        
        func declineFriendRequest() {
            print("Friend request declined")
        }
    }
    
    
    
    private func findFriends() {
        
        // Make call to user tabel i database and fetch friends
        let queryFriends = PFQuery(className: "Friends")
        print("Hher3")
        queryFriends.whereKey("user1", equalTo: (PFUser.currentUser()?.objectId)!)
        queryFriends.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            print("Hher2")
            if error == nil {
                for object in objects! {
                    print("Hher1")
                    if (object["user1"] as? String == PFUser.currentUser()?.objectId){
                        self.myFriends.addObject(object["user2"] as! String)
                        print(2)
                    } else {
                        self.myFriends.addObject(object["user1"] as! String)
                        print(1)
                    }
                    
                }
                
            } else {
                print(error)
            }
            self.friendsTable.reloadData()
            
            
        })
       

        
    }
    
    
    
    
    
    // MARK - table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myFriends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: tableViewCell = self.friendsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell
        
        cell.titleLabel.text = self.myFriends.objectAtIndex(indexPath.row) as? String
        cell.addButton.tag = indexPath.row
            
        
        print("Cell!")
        return cell
        
    }
    
    

}

