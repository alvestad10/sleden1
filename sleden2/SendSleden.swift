//
//  SendSleden.swift
//  sleden2
//
//  Created by Daniel Alvestad on 17/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import Foundation
import Parse

class SendSleden {
    
    
    
    let type: Type
    var user: String
    
    
    init(user: String, type: Type) {
        
        self.type = type
        self.user = user
        
    }
    
    convenience init(type: Type) {
        self.init(user: "", type: type)
    }
    
    
    
    
    
    
    func prepareSleden(view: UIViewController){
        let query: PFQuery = PFUser.query()!
        
        query.whereKey("username", equalTo: user)
        query.findObjectsInBackgroundWithBlock({(object: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if object!.count == 1 {
                    let userObject = (object?.first as? PFUser)!
                    self.sendSleden(view, userOb: userObject)
                    print("Fant brukeren")
                } else if object!.count > 1 {
                    print("Flere brukere med samme navn!!")
                } else {
                    sledenView.showAlertWithOK(view, title: "Invalide", message: "No users with this username")
                }
            } else {
                print(error)
            }
            
            
        })

        
    }
    
    
    
    func sendSleden(view: UIViewController, userOb: PFUser?){
        
        if let userID: String = userOb!.objectId {
            
            let queryAddSleden = PFQuery(className: "sleden")
            queryAddSleden.whereKey("userID", equalTo: userID)
            queryAddSleden.findObjectsInBackgroundWithBlock({(objects: [PFObject]?, error: NSError?) -> Void in
                
                
                if error == nil {
                    print("Før forløkken!")
                    if let object: PFObject = objects![0] as PFObject {
                        print("Ineher!!")
                        object[(self.type.getTypeDB())] = (object[(self.type.getTypeDB())] as? Int)! + 1
                        object.saveInBackground()
                        sledenView.showAlertWithOK(view, title: "Success", message: "\(self.type.rawValue) send to \(self.user)")
                        
                    } else if objects!.count == 0 {
                        print("Ineher2!!")
                        let newObject: PFObject = PFObject(className: "sleden")
                        
                        newObject["userID"] = userID
                        
                        if self.type == Type.Sleden {
                            newObject["sleden"] = 1
                            newObject["vaagen"] = 0
                        } else {
                            newObject["sleden"] = 0
                            newObject["vaagen"] = 1
                        }
                        
                        newObject.saveInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
                            
                            if (success) {
                                sledenView.showAlertWithOK(view, title: "Success", message: "\(self.type.rawValue) send to \(self.user)")
                            } else {
                                print(error)
                            }
                        })
                        
                    } else {
                        print("Flere like brukerIDeer i sleden classen")
                    }
                    
                } else {
                    print(error)
                }
            })
            
            
        }
    }
    
    
    
}


