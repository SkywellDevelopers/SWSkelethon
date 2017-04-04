//
//  StoryBoardable.swift
//  lico
//
//  Created by Krizhanovskii on 10/18/16.
//  Copyright © 2016 k.krizhanovskii. All rights reserved.
//

import Foundation
import UIKit


/// Storyboard protocol
public protocol StoryboardProtocol {
    static var storyboardName: String {get}
}


public extension StoryboardProtocol where Self:UIViewController {
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: Self.storyboardName, bundle: nil)
    }
    
    /// try get initial storyboard cntrl
    ///
    /// - Returns: UIVIewController type
    public static func instantiateInitialViewController() -> Self {

        guard let cntrl = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not find contoller for \(String(describing: Self.self))")
        }
        return cntrl
    }

    /// try get initial storyboard cntrl
    ///
    /// - Returns: UINavigationController type
    public static func storyBoardWithNavigationContoller<T: UINavigationController>() -> T {
        guard let cntrl = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Could not find navigation for \(String(describing: Self.self))")
        }
        return cntrl
    }

    /// try get initial storyboard cntrl
    ///
    /// - Returns: UITabBarController type
    public static func storyBoardWithTabBarController<T: UITabBarController>() -> T {
        guard let cntrl = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Could not find tabbarcontroller for \(String(describing: Self.self))")
        }

        for c in cntrl.childViewControllers {
            c.loadViewIfNeeded()
        }
        return cntrl
    }

    /// try get initial storyboard cntrl
    ///
    /// - Returns: Couple of UIViewController and UINavigationController
    public static func storyboardControllerInsideContainer(_ navigation: UINavigationController.Type) -> (Self, UINavigationController) {
        let cntrl = Self.instantiateInitialViewController()
        let nav = navigation.init(rootViewController: cntrl)
        return (cntrl, nav)

    }
}

public extension UIStoryboard {
    /// try get cntrl with the storyboardID == ClassName
    ///
    /// - Parameter cntrl: UIViewController Type
    /// - Returns: return UIViewController type controller
    public func instantiateViewController<T: UIViewController>(_ cntrl: T.Type) -> T {
        guard let vc = self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not find cntrl  in storyboard:\(String(describing: self))for \(String(describing: T.self))")
        }
        return vc
    }
}
