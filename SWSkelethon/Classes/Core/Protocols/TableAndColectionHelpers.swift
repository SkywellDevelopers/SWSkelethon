//
//  ReusableProtocol.swift
//  lico
//
//  Created by Krizhanovskii on 9/22/16.
//  Copyright © 2016 k.krizhanovskii. All rights reserved.
//

import Foundation
import UIKit

/// This protocols and extension helps to fastes work with TableView and collcetionView
/// For fast setup cell design
/// - no need to add cell in storyboard or xib.
/// - need register from code

///EXAMPLE:
/*
// registe cell
func registerCells() {
    self.tableView.register(SWPartnersLinksCell.self)
}

// get cell
let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SWPartnersLinksCell
*/

/// RegisterCellProtocol view protocol helps to resiter cell for table view or colection view
public protocol RegisterCellProtocol {
    func configure() // optioanl.
}

/// optional func configure
extension RegisterCellProtocol {
    func configure() {}
}

/// return String ident fron self name
extension RegisterCellProtocol where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }
}

/// Register and dequeue cell from table
extension UITableView {
    /// reload table with saving content position
    func reloadDataWithSaveContentOffset() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }

    /// Register cell
    ///
    /// - Parameter _: UITableViewCell.Type that conform RegisterCellProtocol
    func register<T: UITableViewCell>(_: T.Type) where T: RegisterCellProtocol {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Register cell with NIB name. Nib name must be equal to ClassName.
    ///
    /// - Parameter _: UITableViewCell.Type that conform RegisterCellProtocol
    func registerNib<T: UITableViewCell>(_: T.Type) where T: RegisterCellProtocol {
        guard (Bundle.main.path(forResource: T.nibName, ofType: "nib") != nil) else {
            fatalError("Could not find xib with name: \(T.nibName)")
        }
        self.register(UINib(nibName:T.nibName, bundle:nil), forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewCell, Z: UITableViewCell>(_: T.Type, withNib:Z.Type) where T: RegisterCellProtocol, Z: RegisterCellProtocol {
        guard (Bundle.main.path(forResource: Z.nibName, ofType: "nib") != nil) else {
            fatalError("Could not find xib with name: \(T.nibName)")
        }
        Log.info.log("REGISTER WITH IDENT \(T.reuseIdentifier)")
        self.register(UINib(nibName:Z.nibName, bundle:nil), forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Dequeue cell. CellClass must confrom RegisterCellProtocol
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: UITableViewCell type
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: RegisterCellProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            Log.error.log(dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath))
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

/// Register and dequeue cell from colection
extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: RegisterCellProtocol {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UICollectionViewCell>(_: T.Type) where T: RegisterCellProtocol {
        guard (Bundle.main.path(forResource: T.nibName, ofType: "nib") != nil) else {
            fatalError("Could not find xib with name: \(T.nibName)")
        }
        self.register(UINib(nibName:T.nibName, bundle:nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: RegisterCellProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
