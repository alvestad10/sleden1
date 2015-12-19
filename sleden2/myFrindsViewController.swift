//
//  myFrindsViewController.swift
//  sleden2
//
//  Created by Daniel Alvestad on 12/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit


class myFrindsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView

    @IBOutlet weak var friendsTable: UITableView!
    
    //var myFriends: NSMutableArray! = NSMutableArray()
    var getFriends: GetFriends = GetFriends()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Oppretter Activity Indicator (Den som spinne i midten)
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        
        // Henter alle som er venner og plasserer de i getFriends objectet
        getFriends.findFriends(self.friendsTable, actInt: self.actInd)
        
        self.friendsTable.reloadData()
        
    }

        
    
    // MARK - table view
    
    // Legger til antall rader som skal være i tabellen når den oppdateres
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getFriends.myFriends.count
    }
    
    // Legger til de forskjellige cellene i tabellen
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: tableViewCell = self.friendsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell
        cell.titleLabel.text = self.getFriends.myFriendsTable.objectAtIndex(indexPath.row) as? String
        cell.addButton.tag = indexPath.row
        return cell
        
    }
    
    

}

