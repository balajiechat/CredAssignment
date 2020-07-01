//
//  CREDCardConfigurator.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

class CREDCardConfigurator {

    static func configCREDCardModule() -> CREDCardVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let credCardVC = storyboard.instantiateViewController(withIdentifier: "CREDCardVC") as! CREDCardVC
        let interactor = CREDCardInteractor()
        let router = CREDCardRouter()
        router.credCardVC = credCardVC
        let presenter = CREDCardPresenter(view: credCardVC, interactor: interactor, router: router)
        interactor.presenter = presenter
        credCardVC.presenter = presenter

        return credCardVC
    }
    
}
