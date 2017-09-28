//
//  EXView.swift
//  SWSkelethon_Example
//
//  Created by Krizhanovskii on 9/20/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SWSkelethon

class EXView: UIView, RegisterViewProtocol {

    // MARK: - RegisterViewProtocol
    var view: UIView! {
        didSet {
            configure()
            configureStaticTexts()
            configureColors()
        }
    }
    
    func configure() {
    }
    
    func configureColors() {
    }
    
    func configureStaticTexts() {
        print("called")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ({ view = xibSetuView() })()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ({ view = xibSetuView() })()
    }
}
