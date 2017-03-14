//
//  Logger.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import UIKit

public enum Log : String {
    case verbose = "💜"
    case debug = "💚"
    case info = "💙"
    case warning = "💛"
    case error = "❤️"
    
    
    public func log(_ message : String) {
        dPrint("\(self.rawValue):) \(message)")
    }
    
    
    public func log(_ items: Any...) {
        
        dPrint("\(self.rawValue):) \(items)")
        
    }
    
    public func log(_ name:String, _ parameters:DictionaryAlias?) {
        dPrint("----")
        dPrint(name)
        guard let _ = parameters else {
            dPrint("none \n----")
            return
        }
        dPrint("key : value")
        for (key,value) in parameters! {
            dPrint("\(key) : \(value)")
        }
        dPrint("----")
    }
}



func dPrint(_ items: Any...) {
    #if DEBUG
        print(items)
    #endif
}
