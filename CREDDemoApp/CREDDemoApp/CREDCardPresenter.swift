//
//  CREDCardPresenter.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

protocol CREDCardPresenterInputProtocol {
    func getCardData()
    func performSelectedAction(name: String)
}

class CREDCardPresenter: CREDCardPresenterInputProtocol {

    private weak var view: CREDCardViewProtocol?
    private var interactor: CREDCardInteractorProtocol?
    private var router: CREDCardRouter?

    required init(view: CREDCardViewProtocol, interactor: CREDCardInteractorProtocol, router: CREDCardRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func getCardData() {
        self.interactor?.getCardData()
    }

    func performSelectedAction(name: String) {
        self.router?.showAlert(title: "Selected Action", message: name)
    }

}

extension CREDCardPresenter: CREDCardPresenterOutputProtocol {

    func cardDetails(models: [CREDCardModel]) {
        self.view?.updateCardVC(models: models)
    }

}
