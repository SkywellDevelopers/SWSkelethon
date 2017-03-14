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
    public static func saveModelToStorage<M: ModelProtocol>(_ model: M) where M:Object {
        self.updateObject(model)
    }

    ///  Save Realm Array model with update
    ///
    /// - Parameter model: Array  of model
    public static func saveModelArrayToStorage<M: ModelProtocol>(_ array: Array<M>) where M: Object {
        for item in array {
            self.updateObject(item)
        }
    }

    ///  Update Realm Array model with update
    ///
    /// - Parameter model: model
    public static func updateObject<M: ModelProtocol>(_ model: M) where M: Object {
        do {
            let r = try Realm()
            try r.write {
                r.add(model, update: true)
            }
        } catch {
            Log.error.log("RealmSavebale: error \(error.localizedDescription) with saving type \(M.self)")
        }
    }

    /// Remove data from table
    ///
    /// - Parameter type: Object.Type
    public static func removeFrom<R: Object>(_ type: R.Type) {
        do {
            let items  = try Realm().objects(type.self)
            let realm = try Realm()

            for item in items {
                try realm.write {
                    realm.delete(item)
                }
            }
        } catch {
            Log.warning.log("\(type.self) not created")
        }
    }

    /// Fetch all items that conform NSPredicate
    ///
    /// - Parameters:
    ///   - type: Realm Object type
    ///   - predicate: NSPredicate
    ///   - success: array of model
    public static func fetchItems<M: ModelProtocol>(_ type: M.Type,
                                                    predicate: NSPredicate,
                                                    success: (Array<M>)->Void) where M: Object {
        Log.info.log("Fetching items with predicate \(predicate)")
        do {
            let cattegories  = try Realm().objects(M.self).filter(predicate)
            var resultArray = Array<M>()
            for cattegiry in cattegories {
                resultArray.append(cattegiry)
            }
            success(resultArray)
        } catch {
            Log.error.log("RealmFetcheble: error with type \(type)")
        }
    }

    /// Fetch all items
    ///
    /// - Parameters:
    ///   - type: Realm Object type
    ///   - success: array of model
    public static func fetchAllItems<M: ModelProtocol>(
                                                      _ type: M.Type,
                                                      success: (Array<M>)->Void,
                                                      failure: @escaping ResponseHandler
                                                      ) where M: Object {
        do {
            let cattegories  = try Realm().objects(M.self)
            var resultArray = Array<M>()
            for cattegiry in cattegories {
                resultArray.append(cattegiry)
            }
            success(resultArray)
        } catch {
            Log.error.log("RealmFetcheble: error with type \(M.self)")
            failure(ErrorResponse(.objectNotFound, message: "RealmFetcheble: error with type \(M.self)"))
        }
    }
}
