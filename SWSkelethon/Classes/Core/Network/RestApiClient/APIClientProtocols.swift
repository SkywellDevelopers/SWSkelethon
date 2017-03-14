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

// Type aliases
public typealias ArrayOfDictionaries = Array<[String: Any]>
public typealias DictionaryAlias = [String: Any]
public typealias DictionaryAliasHashable = [AnyHashable: Any]
public typealias Method = Alamofire.HTTPMethod
public typealias ResponseHandler = (ErrorParserProtocol) -> Void

/// Model protocol
///
/// Need to create model from Dictionary
public protocol ModelProtocol {
    init(resp: DictionaryAlias)
    init()
}

/// Listable protocol
///
/// Need for making Array of ModelProtocol
public protocol Listable {}

public extension Listable where Self:ModelProtocol {
    /// Converting `Array<[String:Any]>` to `Array<ModelProtocol>`
    ///
    /// - Parameter array: array of dictionaries
    /// - Returns: array of models
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
    associatedtype Type: ModelProtocol
    init (JSON: DictionaryAlias)
}

/// Request protocol.
public protocol APIRequestProtocol {
    /// Response Type that conform `APIResponseProtocol`
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
/// Required `ResponseParser` that conform `ResponseParserProtocol` and `baseURL` of server
public protocol RestApiClienProtocol {
    associatedtype ResponseParser: ResponseParserProtocol
    var baseUrl: String {get}
}

public extension RestApiClienProtocol {

    /// NON RX. Create and execute request.
    ///
    /// - Parameters:
    ///   - encoding: ParameterEncoding, by default JSONEncoding.default
    ///   - request: request object that confrom APIRequestProtocol
    ///   - success: response object that conform APIResponseProtocol
    ///   - failure: ResponseHandler function. Can be `nil`.
    /// - Returns: return `Request` object or `nil`
    public func executeRequest<T: APIRequestProtocol>(encoding: ParameterEncoding = JSONEncoding.default,
                                                      request: T,
                                                      success: ((T.Response) -> Void)? = nil,
                                                      failure: ResponseHandler? = nil) -> Request? {

        let requestPath = "\(baseUrl)\(request.path)"

        Log.verbose.log("-------")
        Log.verbose.log("request \(requestPath)")
        Log.verbose.log("Parameters:", request.parameters)
        Log.verbose.log("method \(request.HTTPMethod)")
        Log.verbose.log("Headers:", request.headers)
        Log.verbose.log("-------")

        return Alamofire.request(requestPath, method: request.HTTPMethod, parameters: request.parameters, encoding: encoding, headers: request.headers).responseJSON { response in
            Log.verbose.log("-------")
            Log.verbose.log("response for \(requestPath)")
            Log.verbose.log(response.value ?? "no response")
            Log.verbose.log("-------")
            ResponseParser.parseResponse(response: response, request: request, success: success, failure: failure)
        }
    }

    /// RX. Create and execute request.
    ///
    /// - Parameters:
    ///   - encoding: ParameterEncoding, by default JSONEncoding.default
    ///   - request: request class that confrom APIRequestProtocol
    /// - Returns: Return observable that emits classes that conforms APIResponseProtocol
    public func rx_execute<T: APIRequestProtocol>(encoding: ParameterEncoding = JSONEncoding.default, request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let requestPath = "\(self.baseUrl)\(request.path)"

            Log.verbose.log("-------")
            Log.verbose.log("request \(requestPath)")
            Log.verbose.log("Parameters:", request.parameters)
            Log.verbose.log("method \(request.HTTPMethod)")
            Log.verbose.log("Headers:", request.headers)
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
