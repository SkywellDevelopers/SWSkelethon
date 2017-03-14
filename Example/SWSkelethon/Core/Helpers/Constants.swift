//
//  Constants.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import UIKit
import SkyWellSkelethon


struct Constants {
    // Server
    struct  Server {
        static let kBaseUrl = ""
    }
    
    
    // Time values
    struct Time {
        static let kStandartTime = 0.75
        static let kShortTime = 0.35
    }
    

    
    // Keys
    enum Keys : String {
        case firstLaunch = "FirstLaunch"
        
        func getValue() -> Any? {
            let _value = UserDefaults.standard.value(forKey: self.rawValue)
            Log.info.log("Getting value for key: <\(self.rawValue)> -> <\(_value)>")
            return _value
        }
        
        func setValue(_ value:Any) {
            Log.info.log("Set value: <\(value)> for key: <\(self.rawValue)>")
            UserDefaults.standard.set(value, forKey: self.rawValue)
        }
        
        func removeValue() {
            Log.info.log("Remove value for key: <\(self.rawValue)>")
            UserDefaults.standard.removeObject(forKey: self.rawValue)
        }
    }
    
    // layer
    struct layer {
        static let kCornerRaidus : CGFloat = 6
    }

}
