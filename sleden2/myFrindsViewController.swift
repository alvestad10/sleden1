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
    
    //var myFriends: NSMutableArray! = NSMutableArray()
    var getFriends: GetFriends = GetFriends()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getFriends.findFriends(self)
        
        self.friendsTable.reloadData()
        
        
    }
    
    func updateTableFromModule() {
        self.friendsTable.reloadData()
    }
        
    
    // MARK - table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.getFriends.myFriendsTable.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: tableViewCell = self.friendsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell
        
        cell.titleLabel.text = self.getFriends.myFriendsTable.objectAtIndex(indexPath.row) as? String
        cell.addButton.tag = indexPath.row
        
        print("Cell!")
        return cell
        
    }
    
    

}

