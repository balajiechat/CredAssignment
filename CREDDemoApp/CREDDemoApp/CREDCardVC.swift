//
//  CREDCardVC.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

protocol CREDCardViewProtocol: class {

    var presenter: CREDCardPresenter? { get set }

    func updateCardVC(models: [CREDCardModel])

}

class CREDCardVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    var presenter: CREDCardPresenter?

    private var models = [CREDCardModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.getCardData()
    }

    deinit {
        print("deinit")
    }
}

extension CREDCardVC: CREDCardViewProtocol, CREDCardCellDelegate {

    func resetLastSwipedCard(model: CREDCardModel?) {
        if let swipedModel = self.models.filter ({ $0.isSwiped == true }).last, swipedModel.cardID != model?.cardID {
            swipedModel.isSwiped = false
            let cell = tableview.cellForRow(at: IndexPath(row: 0, section: swipedModel.cardID - 1)) as? CREDCardCell
            cell?.resetSwipeView()
        }
    }

    func selectedAction(name: String) {
        self.presenter?.performSelectedAction(name: name)
    }

    func updateCardVC(models: [CREDCardModel]) {
        self.models = models
        self.tableview.reloadData()
    }

}

extension CREDCardVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CREDCardCell
        cell.updateCardView(model: self.models[indexPath.section])
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
