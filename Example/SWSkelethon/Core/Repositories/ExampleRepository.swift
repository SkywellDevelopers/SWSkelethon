//
//  ExampleRepository.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SWSkelethon


struct ExampleRepository {
    static let apiClient = ExampleRestAPIClient()
    static private let bag = DisposeBag()

    static func example(_ params:DictionaryAlias, success: @escaping (Array<ExampleModel>) -> Void, failure: @escaping ResponseHandler) {
        
        
        _ = apiClient.executeRequest(request: ExampleRequest(), success: { (items) in
            //your items
            let _ = items.model // your items
            success(items.model)
        }, failure: failure)
        
        
    }
    
    
    static func exampleWithRX(_ params:DictionaryAlias, success: @escaping (Array<ExampleModel>) -> Void, failure: @escaping ResponseHandler) {
        
        
        apiClient.rx_execute(request: ExampleRequest())
            .subscribe(onNext:{ response in
                var _ = response.model // you items
                success(response.model)
            }, onError: { error in
                failure(ExampleErrorParser.handleError(error))
            })
            .addDisposableTo(bag)
    }
}
