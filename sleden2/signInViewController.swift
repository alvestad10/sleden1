//
//  signInViewController.swift
//  sleden2
//
//  Created by Daniel Alvestad on 12/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import UIKit
import Parse


class signInViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        
        
    }
    
    
    @IBAction func signInButton(sender: AnyObject) {
        
        let username = usernameField.text
        let password = passwordField.text
        let email = emailField.text
        
        if (username == nil || password == nil || email == nil){
            
            let alert = UIAlertController(title: "Invalid", message:"Username, password or email is empty", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
            return
            
        }
        
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5){
            
            let alert = UIAlertController(title: "Invalid", message:"Username must be greater then 4 and Password must be greater then then 5.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
            
        } else if(email?.utf16.count < 8){
            
            let alert = UIAlertController(title: "Invalid", message:"The email you typed was less then 8 caracters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else {
            self.actInd.startAnimating()
            
            let newUser = PFUser()
            
            newUser.email = email
            newUser.username = username
            newUser.password = password
            
            newUser.signUpInBackgroundWithBlock({(user,error) -> Void in
            
                self.actInd.stopAnimating()
                
                if ((error) != nil){
                    let alert = UIAlertController(title: "Invalide", message:"\(error)", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    
                } else {
                    let alert = UIAlertController(title: "Success", message:"User \(username!) Created", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { alertAction in
                        
                        self.performSegueWithIdentifier("startAppSign", sender: user)
                        
                        
                        })
                    self.presentViewController(alert, animated: true){}
                    
                    
                }
            
            
            })
            
            
        }
        
        
    }
    

}
