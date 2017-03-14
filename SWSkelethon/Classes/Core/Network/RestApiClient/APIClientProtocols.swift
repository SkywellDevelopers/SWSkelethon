//
//  APIRequestProtocol.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

/// Type aliases
public typealias ArrayOfDictionaries = Array<[String:Any]>
public typealias DictionaryAlias = [String:Any]
public typealias DictionaryAliasHashable = [AnyHashable:Any]
public typealias Method = Alamofire.HTTPMethod
public typealias ResponseHandler = (ErrorParserProtocol) -> Void


/// Model protocl
public protocol ModelProtocol {
    init(resp:DictionaryAlias)
    init()
}

/// Listable protocol for making Array of ModelProtocol object
public protocol Listable {}

public extension Listable where Self:ModelProtocol {
    /// converting array of dicts to Array of ModelProtocol objects
    public static func getList(_ array: ArrayOfDictionaries) -> Array<Self> {
        if array.count > 0 {
            var result = Array<Self>()
            for item in array {
                result.append((Self(resp: item)))
            }
            return result
        }
        return Array<Self>()
    }
}

/// Response protocol
public protocol APIResponseProtocol {
    associatedtype T : ModelProtocol
    init (JSON:  DictionaryAlias)
}


/// equest Protocol
public protocol APIRequestProtocol {
    /// Response Type
    associatedtype Response: APIResponseProtocol
    
    var HTTPMethod: Method { get }
    var parameters: [String: Any]? {get}
    var headers: [String: String] {get set}
    var path: String { get }
}

public extension APIRequestProtocol {
    var HTTPMethod: Method { return .get }
    var parameters: [String: Any]? { return nil }
}


/// Rest Api client protocol
public protocol RestApiClienProtocol {
    associatedtype ResponseParser : ResponseParserProtocol
    var baseUrl : String {get}
}

public extension RestApiClienProtocol {
    /// NON RX execute function for sending and parsing request
    ///
    /// - Parameters:
    ///   - encoding: ParameterEncoding, by default JSONEncoding.default
    ///   - request: request class that confrom APIRequestProtocol
    ///   - success: response file that conform APIResponseProtocol
    ///   - failure: ResponseHandler function
    /// - Returns: return nil  all created request
    
    public func executeRequest<T: APIRequestProtocol>(encoding:ParameterEncoding = JSONEncoding.default,
                        request: T,
                        success: ((T.Response) -> Void)? = nil,
                        failure: ResponseHandler? = nil) -> Request? {
        
        let requestPath = "\(baseUrl)\(request.path)"
        
        Log.verbose.log("-------")
        Log.verbose.log("request \(requestPath)")
        Log.verbose.log("Parameters:",request.parameters)
        Log.verbose.log("method \(request.HTTPMethod)")
        Log.verbose.log("Headers:",request.headers)
        Log.verbose.log("-------")
        
        return Alamofire.request(requestPath, method: request.HTTPMethod, parameters: request.parameters, encoding: encoding, headers: request.headers).responseJSON { response in
            Log.verbose.log("-------")
            Log.verbose.log("response for \(requestPath)")
            Log.verbose.log(response.value ?? "no response")
            Log.verbose.log("-------")
            ResponseParser.parseResponse(response: response, request: request, success: success, failure: failure)
        }
    }
    
    /// RX executable function
    ///
    /// - Parameters:
    ///   - encoding: ParameterEncoding, by default JSONEncoding.default
    ///   - request: request class that confrom APIRequestProtocol
    /// - Returns: Return observable that emits classes that conforms APIResponseProtocol
    public func rx_execute<T: APIRequestProtocol>(encoding:ParameterEncoding = JSONEncoding.default,request: T) -> Observable<T.Response> {
        return Observable.create{ observer in
            
            let requestPath = "\(self.baseUrl)\(request.path)"
            
            Log.verbose.log("-------")
            Log.verbose.log("request \(requestPath)")
            Log.verbose.log("Parameters:",request.parameters)
            Log.verbose.log("method \(request.HTTPMethod)")
            Log.verbose.log("Headers:",request.headers)
            Log.verbose.log("-------")
            
            let request = Alamofire.request(requestPath, method: request.HTTPMethod, parameters: request.parameters, encoding: encoding, headers: request.headers).responseJSON { response in
                Log.verbose.log("-------")
                Log.verbose.log("response for \(requestPath)")
                Log.verbose.log(response.value ?? "no response")
                Log.verbose.log("-------")
                
                ResponseParser.parseResponse(response: response, request: request, success: { (model) in
                    observer.on(.next(model))
                    observer.on(.completed)
                }, failure: { (error) in
                    observer.on(.error(error))
                })
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

