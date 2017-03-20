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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Log.debug.log("Your first log!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLogPressed(_ sender: Any) {
        Log.debug.log("log!")
    }
}




class MyModel : Object {
    dynamic var x : String?
    
    convenience init(resp:DictionaryAlias) {
        self.init()
        self.x = resp[""] as? String ?? stringDummy
        
        
    }
}
