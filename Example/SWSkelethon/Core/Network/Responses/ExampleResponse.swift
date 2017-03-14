//
//  ExampleResponse.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import SWSkelethon

struct ExampleResponse : APIResponseProtocol {
    typealias T = ExampleModel
    var model:Array<T> = Array<T>()
    init(JSON: DictionaryAlias) {
//        model = ExampleModel.getList(//)
    }
}
