//
//  ErrorParserProtocol.swift
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 K.Krizhanovskii. All rights reserved.

import Foundation
import Alamofire

// Status codes codes
public enum StatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    
    case badRequest = 400
    case badCredentials = 401
    case accessForbidden = 403
    case objectNotFound = 404
    
    case unprocessableEntity = 422
    case limitedRequest = 429
    
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    
    case noInternetConnection = -1009
    case requestTimeout = -1001
    case internetConnectionWasLost = -1005
    case serverCouldNotBeFound = -1003
    
    var isRequestErrorCode: Bool {
        return 400..<500 ~= rawValue
    }
}


/// Error parser protocol
public protocol ErrorParserProtocol:Swift.Error {
    /// status code for internet response
    var statusCode : StatusCode {get}
    /// message with server error
    var message : String {get set}
    
    /// init with status code and message
    init(_ statusCode: StatusCode, message: String)
    
    ///
    /// Parse Error json from server and return Error class
    ///
    /// - Parameter JSON: JSON response from server
    /// - Returns: Self Error class
    static func parseError(_ JSON: AnyObject) -> Self
    
}

/// Extensions for type cast Swift.Error to ErrorParserProtocol
public extension ErrorParserProtocol {
    /// Static function for convert `Swift.Error` to `Self` error
    ///
    /// - Parameter error: Swift.Error
    /// - Returns: error object that conform `ErrorParserProtocol`
    static func handleError(_ error: Swift.Error) -> Self {
        if let myError = error as? Self {
            return myError
        } else {
            return Self(.badRequest, message: error.localizedDescription)
        }
    }
}






