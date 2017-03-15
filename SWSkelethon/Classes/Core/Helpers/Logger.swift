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
    case verbose = "💜 VERBOSE"
    case debug = "💚 DEBUG"
    case info = "💙 INFO"
    case warning = "💛 WARNING"
    case error = "❤️ ERROR"

    /// Log items in console. Print only in *debug* mode.
    /// In console its look like: 💚 DEBUG: ViewController.swift.18:viewDidLoad(): ATATAT
    ///
    /// - Parameters:
    ///   - items: items for print
    ///   - file: file name where `log` was called
    ///   - line: line where `log` was called
    ///   - function: function name where `log` was called
    public func log(_ items: Any..., file: String = #file, line: Int = #line, function: String = #function) {
        let shortFile = file.components(separatedBy: "/").last ?? file
        var result = "\(self.rawValue): \(shortFile).\(line):\(function): "
        items.forEach { (item) in
            result.append("\(item) ")
        }
        dPrint(result)
    }

    /// Log dictionary objects.
    /// In console its look like:
    /// ---------------------------------------------------------------------
    /// 💙 INFO: ViewController.swift.20:viewDidLoad(): Headers
    /// key : value
    /// Header : accept
    /// ---------------------------------------------------------------------
    ///
    ///  - Parameters:
    ///   - name: Name of grouped. Example: `Headers`
    ///   - parameters: Dictionary. Example `["Accept-Lnaguage":"ru"]`
    ///   - file: file name where `log` was called
    ///   - line: line where `log` was called
    ///   - function: function name where `log` was called
    public func log(_ name:String, parameters:DictionaryAlias?, file: String = #file, line: Int = #line, function: String = #function) {
        dPrint("---------------------------------------------------------------------")
        self.log(name, file: file, line: line, function: function)
        guard let _ = parameters else {
            dPrint("none \n----")
            return
        }
        dPrint("key : value")
        for (key,value) in parameters! {
            dPrint("\(key) : \(value)")
        }
        dPrint("---------------------------------------------------------------------")
    }
}

fileprivate func dPrint(_ items: Any...) {
        items.forEach({item in
            print(item)
        })
}
