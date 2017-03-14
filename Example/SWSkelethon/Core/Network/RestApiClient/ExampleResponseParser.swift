//
//  ExampleResponseParser.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import Alamofire
import SWSkelethon


class ExampleResponseParser:ResponseParserProtocol {
    typealias ErrorParser = ExampleErrorParser
    
    static func parseResponse<T: APIRequestProtocol>(response: DataResponse<Any>,
                              request: T,
                              success: ((T.Response) -> Void)? = nil,
                              failure: ResponseHandler? = nil) {
        
        switch response.result {
        case .failure(let error):
            let err = error as NSError
            failure?(
                ErrorParser(
                    StatusCode(rawValue: err.code) ?? .badRequest,
                    message: (response.result.value as? DictionaryAlias)?["message"] as? String ?? err.localizedDescription
                )
            )
            
            return
        default:
            break
        }
        
        guard let JSON = response.result.value as AnyObject? else {
            return
        }
        
        if let statusCode = response.response?.statusCode , 200..<300 ~= statusCode {
            if let dict = JSON as? DictionaryAlias {
                success?(T.Response(JSON: dict))
            } else if let arrOfDict = JSON as? ArrayOfDictionaries {
                success?(T.Response(JSON: ["data":arrOfDict]))
            } else {
                success?(T.Response(JSON: [:]))
            }
        } else {
            failure?(ErrorParser.parseError(JSON))
        }
    }
}
