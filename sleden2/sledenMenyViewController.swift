//
//  sledenMenyViewController.swift
//  sleden2
//
//  Created by Daniel Alvestad on 12/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit
import Parse

class sledenMenyViewController: UIViewController {
    
    var sledenType: Type?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sledenLabel: UILabel!
    @IBOutlet weak var vaagenLabel: UILabel!
    @IBOutlet weak var sledenScoreLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = PFUser.currentUser()?.username
        
        updateSledenScore()
        
    }
    @IBAction func updateButton(sender: AnyObject) {
        
        updateSledenScore()
        
    }
    
    
    
    @IBAction func vennerButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("tilVenner", sender: self)
    }
    
    @IBAction func sendSleden(sender: AnyObject) {
        self.sledenType = Type.Sleden
        self.performSegueWithIdentifier("sendSleden", sender: self)
        
    }
    
    @IBAction func sendVaagen(sender: AnyObject) {
        self.sledenType = Type.Vaagen
        self.performSegueWithIdentifier("sendSleden", sender: self)
        
        
    }
    
    
    func updateSledenScore() {
        
        
        let query = PFQuery(className: "sleden")
        
        query.whereKey("userID", equalTo: PFUser.currentUser()!.objectId!)
        
        query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objectsNew = objects {
                    
                    for object in objectsNew {
                        print(object["sleden"])
                        if object["sleden"] != nil {
                            print("innenfor")
                            self.sledenLabel.text = "\(object["sleden"])"
                            self.vaagenLabel.text = "\(object["vaagen"])"
                            let sledenScore = (object["sleden"] as? Int)! - (object["vaagen"] as? Int)!
                            self.sledenScoreLabel.text = String(sledenScore)
                        } else {
                            self.sledenLabel.text = "0"
                        }
                    }
                    
                }
                
                
            }
            
            
            
            
        })
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "sendSleden" {
            
            if let senderView: sledenView = segue.destinationViewController as? sledenView {
                
                let newSleden = SendSleden(type: sledenType!)
                senderView.sendASleden = newSleden
                //senderView.type = sledenType
            }
            
        }
        
    }

    
    
    


}
