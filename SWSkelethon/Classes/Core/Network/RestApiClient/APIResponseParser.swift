//
//  APIResponseParser.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import Alamofire


public protocol ResponseParserProtocol {
    associatedtype ErrorParser : ErrorParserProtocol
    static func parseResponse<T: APIRequestProtocol>(response: DataResponse<Any>,
                                                    request: T,
                                                    success: ((T.Response) -> Void)?,
                                                    failure: ResponseHandler?)
}


