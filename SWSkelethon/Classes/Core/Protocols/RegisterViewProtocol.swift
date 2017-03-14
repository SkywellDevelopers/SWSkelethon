//
//  RegisterViewProtocol.swift
//
//  Created by Krizhanovskii on 9/29/16.
//  Copyright © 2016 k.krizhanovskii. All rights reserved.
//

import Foundation
import UIKit

/// Protocol for registration view from code or nib.

///EXMAPLE:
/*
class testView : UIView, RegisterViewProtocol {
 
    /// this required methods by protocol and UIView init
    var view: UIView! {
        didSet {
            self.configure()
            self.configureColors()
            self.configureStaticTexts()
        }
    }
    
    func configure() {
        // config ypur view there
    }
    
    /// init func
    override init(frame: CGRect) {
        super.init(frame: frame)
        // trick: closure for force didSet in view var when init
        ({ view = xibSetuView() })()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ({ view = xibSetuView() })()
    }
}
*/
 

public protocol RegisterViewProtocol {
    var view : UIView! { get }
    func configure() // required. Use this for main view configuration.
    func configureColors() // optional. Use this function for perform colors
    func configureStaticTexts() // optional . Use this function for perform and reload texts
}

extension RegisterViewProtocol {
    func configureColors() {}
    func configureStaticTexts() {}
}

extension RegisterViewProtocol where Self:UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    /// Returns view from nib or create new view programaticaly
    func xibSetuView() -> UIView {
        let nib = UINib(nibName: Self.nibName, bundle: nil)

        var view : UIView
        if Bundle.main.path(forResource: Self.nibName, ofType: "nib") == nil {
            view = UIView(frame: self.bounds)
        } else {
            view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        }
        
        view.frame = bounds
        view.backgroundColor = .white
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        return view
    }
}
