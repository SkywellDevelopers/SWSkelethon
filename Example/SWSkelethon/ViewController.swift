//
//  ViewController.swift
//  SWSkelethon
//
//  Created by k.krizhanovskii@gmail.com on 03/14/2017.
//  Copyright (c) 2017 k.krizhanovskii@gmail.com. All rights reserved.
//

import UIKit
import SWSkelethon
import RealmSwift
import RxSwift
import RxCocoa

class ViewController: BaseViewController, UIViewContent {
    
    
    var viewContent: RegisterViewProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.debug.log("Your first log!")
        
        viewContent = EXView(frame: self.view.bounds) // DI
        
        Observable.just("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLogPressed(_ sender: Any) {
        Log.debug.log("log!")
    }
}


protocol UIViewContent {
    var viewContent: RegisterViewProtocol? { get }
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        (self.childViewControllers.first as? UIViewContent)?.viewContent?.configureStaticTexts()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureText() {
        //        self.childViewControllers.first
    }
    
    func staticText() {
        
    }
}


