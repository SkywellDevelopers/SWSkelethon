//
//  ExampleListViewModel.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SWSkelethon

class ExampleListViewModel : ViewModelProtocol {


    
    var myRxName : Variable<String> = Variable("")
    
    var name:String {
        return ""
    }
    
    typealias ModelType = ExampleModel
    typealias Model = Array<ModelType>
    
    var model: Model
    
    var requestStatus: RequestStatus = {
        return .loading
        }() {
        didSet {
            self.viewModelChanged?()
        }
    }
    var viewModelChanged: (() -> ())?
    
    required init() {
        self.model = Model()
    }
    
    required init(_ model: Model) {
        self.model = model
    }
    
    func set(_ model: Model) {
        self.model = model
    }
    
    //requestable protocol
    func update() {
        self.requestStatus = .loading
        ExampleRepository.exampleWithRX([:], success: { (items) in
            self.set(items)
            self.requestStatus = .success
        }) { (error) in
            self.requestStatus = .error(error)
        }
    }
}
