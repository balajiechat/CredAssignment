//
//  CREDCardModel.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import Foundation


class CREDCardModel {

    var cardName: String?
    var cardID: Int!
    var actions: [String]?
    var isSwiped: Bool = false

    required init(id: Int, name: String) {
        self.cardID = id
        self.cardName = name
    }
}
