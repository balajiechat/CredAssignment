//
//  CredCardCell.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

protocol CREDCardCellDelegate: class {
    func resetLastSwipedCard(model: CREDCardModel?)
    func selectedAction(name: String)
}


class CREDCardCell: UITableViewCell, CREDCardViewDelegate {

    @IBOutlet weak var holderView: UIView!
    private var swipeView: CREDCardView?
    weak var delegate: CREDCardCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSwipeCardView()
    }

    func addSwipeCardView() {
        self.swipeView?.removeFromSuperview()
        if let swipeView = UIView.loadFromNibNamed("CREDCardView") as? CREDCardView {
            swipeView.delegate = self
            swipeView.translatesAutoresizingMaskIntoConstraints = false
            self.holderView.addSubview(swipeView)
            swipeView.leadingAnchor.constraint(equalTo: self.holderView.leadingAnchor).isActive = true
            swipeView.trailingAnchor.constraint(equalTo: self.holderView.trailingAnchor).isActive = true
            swipeView.topAnchor.constraint(equalTo: self.holderView.topAnchor).isActive = true
            swipeView.bottomAnchor.constraint(equalTo: self.holderView.bottomAnchor).isActive = true
            self.swipeView = swipeView
        }
    }

    static var firstRun = false

    func updateCardView(model: CREDCardModel) {
        if CREDCardCell.firstRun == false, model.cardID == 1 {
            CREDCardCell.firstRun = true
            swipeView?.showFirstRun()
        }
        swipeView?.updateCardView(model: model)
    }

    func resetSwipeView() {
        swipeView?.resetSwipeView()
    }

    func resetLastSwipedCard(model: CREDCardModel?) {
        self.delegate?.resetLastSwipedCard(model: model)
    }

    func selectedAction(name: String) {
        self.delegate?.selectedAction(name: name)
    }

}
