//
//  CREDCardRouter.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

class CREDCardRouter {
    
    weak var credCardVC: CREDCardVC?

//    required init(vc: CREDCardVC) {
//        self.credCardVC = vc
//    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let exitAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(exitAction)

        credCardVC?.present(alertController, animated: true, completion:nil)
    }

}
