//
//  RealmProtocol.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import RealmSwift

public protocol RealmProtocol {
    associatedtype ErrorResponse : ErrorParserProtocol
}

public extension RealmProtocol {
    ///  Save Realm model with update
    ///
    ///  Parameter model: model
    /// - Parameter update: update flag
    public static func saveModelToStorage<M: Object>(_ model: M, withUpdate update: Bool = true) {
        self.saveObject(model, withUpdate: update)
    }

    ///  Save Realm Array model with update
    ///
    /// - Parameter model: Array  of model
    /// - Parameter update: update flag
    public static func saveModelArrayToStorage<M: Object>(_ array: Array<M>, withUpdate update: Bool = true) {
        for model in array {
            self.saveObject(model, withUpdate: update)
        }
    }

    ///  Update Realm Array model with update
    ///
    /// - Parameter model: model
    @available(*, deprecated, message: "Use saveObject `func saveObject<M: Object>(_ model: M, withUpdate update:Bool = false)`")
    public static func updateObject<M: Object>(_ model: M) {
        do {
            let r = try Realm()
            try r.write {
                r.add(model, update: true)
            }
        } catch {
            Log.error.log("RealmProtocol: error \(error.localizedDescription) with saving type \(M.self)")
        }
    }
    
    
    
    ///  Save or update object
    ///
    /// - Parameter model: model
    /// - Parameter update:  update flag. default is false
    public static func saveObject<M: Object>(_ model: M, withUpdate update: Bool = false) {
        do {
            let r = try Realm()
            try r.write {
                r.add(model, update: update)
            }
        } catch {
            Log.error.log("RealmProtocol: error \(error.localizedDescription) with saving type \(M.self)")
        }
    }
    

    /// Remove all data from table
    ///
    /// - Parameter type: Object.Type
    public static func removeAllDataFrom<R: Object>(_ type: R.Type) {
        do {
            let items  = try Realm().objects(type.self)
            let realm = try Realm()

            for item in items {
                try realm.write {
                    realm.delete(item)
                }
            }
        } catch {
            Log.warning.log("RealmProtocol: error \(error.localizedDescription). Can't delete all data")
        }
    }
    
    /// Remove sibgle object
    ///
    /// - Parameter object: Object to be removed
    public static func removeObject<R: Object>(_ object: R) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
            Log.warning.log("RealmProtocol: error \(error.localizedDescription). Cannot delete object \(object)")
        }
    }

    /// Fetch all items that conform NSPredicate
    ///
    /// - Parameters:
    ///   - type: Realm Object type
    ///   - predicate: NSPredicate
    ///   - success: array of model
    public static func fetchItems<M: Object>(_ type: M.Type,
                                                    predicate: NSPredicate,
                                                    success: (Array<M>)->Void)  {
        Log.info.log("RealmProtocol: Fetching items with predicate \(predicate)")
        do {
            let cattegories  = try Realm().objects(M.self).filter(predicate)
            var resultArray = Array<M>()
            for cattegiry in cattegories {
                resultArray.append(cattegiry)
            }
            success(resultArray)
        } catch {
            Log.error.log("RealmProtocol: error \(error.localizedDescription), type \(type)")
        }
    }

    /// Fetch all items
    ///
    /// - Parameters:
    ///   - type: Realm Object type
    ///   - success: array of model
    public static func fetchAllItems<M: Object>(
                                                      _ type: M.Type,
                                                      success: (Array<M>)->Void,
                                                      failure: @escaping ResponseHandler
                                                      )  {
        do {
            let objects  = try Realm().objects(M.self)
            var resultArray = Array<M>()
            for obj in objects {
                resultArray.append(obj)
            }
            success(resultArray)
        } catch {
            Log.error.log("RealmProtocol: error \(error.localizedDescription), type \(M.self)")
            failure(ErrorResponse(.objectNotFound, message: "RealmProtocol: error \(error.localizedDescription), type \(M.self)"))
        }
    }
}
