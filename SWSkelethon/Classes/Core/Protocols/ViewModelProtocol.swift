//
//  ViewModelProtocol.swift
//  ACC
//
//  Created by Krizhanovskii on 12/19/16.
//  Copyright © 2016 SkyWell. All rights reserved.
//

import Foundation
import UIKit

/// Request status
public enum RequestStatus {
    case loading // request now loading
    case success // request success complite
    case error(ErrorParserProtocol) // request complite with error
}

/// ViewModel Protocol
public protocol ViewModelProtocol:UpdateProtocol {
    /// ModelType
    associatedtype ModelType:ModelProtocol
    /// Array or Single object. Example: typealias Model = Array<ModelType> or typealias Model = ModelType
    associatedtype Model
    /// Status for current request
    var requestStatus : RequestStatus {get }
    /// Function for force view model update
    var viewModelChanged: ((Void) -> ())? {get set}
    /// Your model variable
    var model : Model {get}
    /// init functions
    init()
    init(_ model:Model)
    /// Set new Model type
    func set(_ model: Model)
}


/// Update protocol
/// Used for load and reload data from storage (remote or local)
public protocol UpdateProtocol {
    func update()
    func update(_ parameters:DictionaryAlias)
    func update(_ page : Int)
}

public extension UpdateProtocol{
    func update() {}
    func update(_ parameters:DictionaryAlias) {}
    func update(_ page : Int) {}
}

/// DataProviderProtocol
/// Used for apply data to the object
public protocol DataProviderProtocol {
    associatedtype DataType
    func set(data : DataType)
}




