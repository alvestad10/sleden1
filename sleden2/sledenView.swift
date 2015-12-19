//
//  sledenView.swift
//  sleden2
//
//  Created by Daniel Alvestad on 15/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit
import Parse

class sledenView: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var sendTypeLabel: UILabel!

    //var type: Type?
    var sendASleden: SendSleden?
    
    override func viewDidLoad() {
        
        //self.sendASleden = SendSleden(type: self.type!)
        
        let getType = sendASleden!.type.rawValue
        sendTypeLabel.text = "Send a \(getType) to: "
        
    }
    
    @IBAction func sledenButton(sender: AnyObject) {
        sendASleden!.user = self.username.text!
        print("Sending sleden to \(sendASleden!.user)")
        sendASleden!.prepareSleden(self)
    }
    
    
    static func showAlertWithOK(view: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        view.presentViewController(alert, animated: true){}
        
        
    }
    
    
    
    
    
    
    
    
    

}


