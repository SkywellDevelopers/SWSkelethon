//
//  ExampleRequest.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation

import Alamofire
import SkyWellSkelethon

struct ExampleRequest:APIRequestProtocol {
    internal var parameters: [String : Any]? = nil
    internal var headers: [String : String] = [:]
    typealias Response = ExampleResponse
    
    init(){}
    
    var HTTPMethod: HTTPMethod {return .get}
    
    var path : String {
        return "/api/v2/"
    }
    
    

}



