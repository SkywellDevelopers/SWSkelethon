//
//  ExampleCntrl.swift
//  TemplateProject
//
//  Created by Krizhanovskii on 3/3/17.
//  Copyright © 2017 skywell.com.ua. All rights reserved.
//

import UIKit
import SWSkelethon

/*
    Цепочка:
    Юзер шлет евент на получение данных
    ->
    Контроллер говорит 'viewModel' что надо получить данные
    -> 
    'viewModel' просит Репозиторий выдать ей данные
    ->
    Репозиторий (в данном примере) бросает запрос на получение данных
    -> 
    RestClient получает данные и возвращает их в репозиторий
    -> 
    Репозиторий (в данном примере) перебрасывает данные во 'viewModel'
    -> 
    'viewModel' обновляет свою модель и меняет RequestStatus 
    ->
    Контроллер ловит изменение в RequestStatus и обвновляет UIView[s]
 
 */

class ExampleCntrl: UIViewController {
    
    /* view model */
    var viewModel : ExampleListViewModel! {
        didSet {
            self.viewModel!.viewModelChanged = { 
                switch self.viewModel!.requestStatus {
                case .loading:
                    Log.debug.log("Loading")
                    //show indicator
                    break;
                case .error(let err):
                    Log.debug.log("Error - \(err.message)")
                    break;
                case .success:
                    Log.debug.log("Succes")
                    break;
                }
            }
        }
    }
    
     var viewModel1 = ExampleListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ExampleListViewModel()
        self.update()
    }
}

extension ExampleCntrl: UpdateProtocol {
    func update() {
        self.viewModel.update()
    }
}

extension ExampleCntrl: StoryboardProtocol {
    static var storyboardName: String {
        return "Main"
    }
}
