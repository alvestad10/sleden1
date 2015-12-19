//
//  findFriendsViewController.swift
//  sleden2
//
//  Created by Daniel Alvestad on 12/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit
import Parse

class findFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var searchField: UITextField!
    
    
    @IBOutlet weak var findFriendsTable: UITableView!
    
    
    var searchResult: NSMutableArray!  = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchResult.addObject("Navn1")
        self.searchResult.addObject("Navn2")
        self.searchResult.addObject("Navn3")
        
        self.findFriendsTable.reloadData()
        
    }
    
    // MARK - table view
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResult.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.findFriendsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell
        
        cell.titleLabel.text = self.searchResult.objectAtIndex(indexPath.row) as? String
        
        cell.addButton.tag = indexPath.row
        
        cell.addButton.addTarget(self, action: "addAction", forControlEvents: .TouchUpInside)
        
        
        return cell
    }
    
    
    @IBAction func addAction(sender: UIButton){
        
        
        let titleString = self.searchResult.objectAtIndex(sender.tag) as? String
        
        let firstActivityItem = "\(titleString)"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    func isFriend(myuser: PFUser, user2: User) -> Bool{
        
        
        let queryFriends = PFQuery(className: "Friends")
        
        var isFriend = false
        
        queryFriends.whereKey("user1", equalTo: myuser.objectId!)
        queryFriends.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    let user1ID = object["user2"] as! String
                    
                    if (user1ID == user2.userID){
                        isFriend = true
                    }
                    
                }
                
            } else {
                print(error)
            }
        
        })
        
        return isFriend

        
    }
    
    
    
    @IBAction func searchButton(sender: AnyObject) {
    
        
        if (searchField == nil) {
            print("Error søkefeltet er tome!")
            return
        }
        
        print(searchField.text!)
        
        let queryUsers = PFQuery(className: "User")
    
        queryUsers.whereKey("username", equalTo: searchField.text!)
        
        queryUsers.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Fikk kontakt med databasen!!! :D :D :D")
                
                print(objects)
                
                for object in objects! {
                    print("Kom in i løkken")
                    let username = object["username"] as! String
                    
                    print(username)
                    
                    
                }
                
            } else {
                print(error)
            }
        
        
        })
        
        
        
        
        
        // Loop trough all the objects inn class!!
        
        
        
        
        
    }

}
