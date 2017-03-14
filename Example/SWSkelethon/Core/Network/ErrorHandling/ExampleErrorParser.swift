//
//  ExampleErrorParser.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import SWSkelethon

struct ExampleErrorParser : ErrorParserProtocol {
    var statusCode: StatusCode = .ok
    var message: String = ""
    
    init(_ statusCode: StatusCode, message: String) {
        
    }
    static func parseError(_ JSON: AnyObject) -> ExampleErrorParser {
        return ExampleErrorParser(.badRequest, message: "")
    }
}
