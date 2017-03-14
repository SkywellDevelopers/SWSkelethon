//
//  Logger.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import UIKit

/// Log
/// Need for `print` to console with `emoji`
public enum Log: String {
    case verbose = "💜"
    case debug = "💚"
    case info = "💙"
    case warning = "💛"
    case error = "❤️"

    /// Log string
    /// - Parameter message: string that be printed in console
    public func log(_ message: String) {
        dPrint("\(self.rawValue): \(message)")
    }

    /// Log items
    /// - Parameter message: items that be printed in console
    public func log(_ items: Any...) {
        dPrint("\(self.rawValue): \(items)")
    }

    /// Log dictionary objects.
    ///
    /// - Parameters:
    ///   - name: Name of grouped. Example: `Headers`
    ///   - parameters: Dictionary. Example `["Accept-Lnaguage":"ru"]`
    public func log(_ name: String, parameters: DictionaryAlias?) {
        dPrint("----")
        dPrint(name)
        guard let _ = parameters else {
            dPrint("none \n----")
            return
        }
        dPrint("key: value")
        for (key, value) in parameters! {
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
