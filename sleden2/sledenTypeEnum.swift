//
//  sledenTypeEnum.swift
//  sleden2
//
//  Created by Daniel Alvestad on 17/12/15.
//  Copyright © 2015 Daniel Alvestad. All rights reserved.
//

import Foundation

enum Type: String {
    case Sleden = "sleden"
    case Vaagen = "vågen"
    
    func getTypeDB() -> String {
        
        if self == Type.Sleden {
            
            return "sleden"
            
        } else {
            return "vaagen"
        }
        
    }
    
    
}