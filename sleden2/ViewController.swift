//
//  ViewController.swift
//  sleden2
//
//  Created by Daniel Alvestad on 12/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (PFUser.currentUser() != nil){
            print("Did log in user")
            self.performSegueWithIdentifier("startAppLog", sender: PFUser.currentUser())
        }
        
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButton(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5){
            let alert = UIAlertController(title: "Invalid", message:"Username must be greater then 4 and Password must be greater then then 5.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: {(user,error) -> Void in
            
                self.actInd.stopAnimating()
                
                if ((user) != nil){
                    let alert = UIAlertController(title: "Success", message:"Logged In", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { alertAction in
                        
                        print("Did log in user")
                        self.performSegueWithIdentifier("startAppLog", sender: user)
                        
                        
                        })
                    self.presentViewController(alert, animated: true){}
                    
                } else {
                    let alert = UIAlertController(title: "Invalide", message:"\(error)", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                }
            })
            
        }
        
        
    }
    
    
    @IBAction func lgoOutButton(sender: AnyObject) {
        PFUser.logOut()
        
        usernameField.text = ""
        passwordField.text = ""
        
    }
    
    
    @IBAction func SignInButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("SignInViewController", sender: self)
        
    }


}

