//
//  CREDCardInteractor.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

protocol CREDCardPresenterOutputProtocol: class {
    func cardDetails(models: [CREDCardModel])
}

protocol CREDCardInteractorProtocol {
    var presenter: CREDCardPresenterOutputProtocol? { get set }

    func getCardData()
}

class CREDCardInteractor: CREDCardInteractorProtocol {

    weak var presenter: CREDCardPresenterOutputProtocol?

    func getCardData() {
        let models = createCREDCardModel()
        self.presenter?.cardDetails(models: models)
    }

    let actionNames = ["zzz", "wind", "snow is the best"]

    private func createCREDCardModel() -> [CREDCardModel] {
        var models = [CREDCardModel]()
        for i in 1...10 {
            let model = CREDCardModel(id: i, name: "CARD \(i)")
            var actions = [String]()
            let count = i%3 == 0 ? 3 : i%3
            for j in 0...count-1 {
                actions.append(actionNames[j])
            }
            model.actions = actions
            models.append(model)
        }

        return models
    }
}

