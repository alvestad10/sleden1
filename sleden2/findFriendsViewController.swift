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
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var findFriendsTable: UITableView!
    
    var users: FindFriends = FindFriends()
    
    
    
    var searchResult: NSMutableArray!  = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Oppretter Activity Indicator (Den som spinne i midten)
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        
        
        let barViewController = self.tabBarController?.viewControllers
        let myFriendsView = barViewController![0] as! myFrindsViewController
        self.users.myFriends = myFriendsView.getFriends.myFriends
        
        
        // Henter alle som er venner og plasserer de i getFriends objectet
        users.allUsernames(self.findFriendsTable, acnInt: self.actInd)
        
        self.findFriendsTable.reloadData()
        
    }
    
    // MARK - table view
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.usersTable.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.findFriendsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell
        cell.titleLabel.text = "\(self.users.usersTable.objectAtIndex(indexPath.row) as? String) (\(self.users.usersTable.objectAtIndex(indexPath.row))"
        cell.addButton.tag = indexPath.row
        
        return cell
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
