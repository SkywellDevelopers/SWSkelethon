//
//  ExampleAPIClient.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import SWSkelethon

class ExampleRestAPIClient : RestApiClienProtocol {
    typealias ResponseParser = ExampleResponseParser
    var baseUrl : String = "baseUrl"
}
