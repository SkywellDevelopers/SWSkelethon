//
//  ExampleModel.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import Foundation
import SWSkelethon
import RealmSwift


class ExampleModel:Object,ModelProtocol, Listable {
    convenience required init(resp: DictionaryAlias) {
        self.init()
    }
    convenience required init() {
        self.init()
    }
}

