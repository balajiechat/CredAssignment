//
//  CREDSwipeView.swift
//  CREDDemoApp
//
//  Created by Balaji S on 06/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

protocol CREDCardViewDelegate: class {
    func resetLastSwipedCard(model: CREDCardModel?)
    func selectedAction(name: String)
}

enum CardState {
    case center
    case left
    case right
}

class CREDCardView: UIView {

    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var stackHolderView: UIView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet var stackActionViews: [UIView]!
    @IBOutlet var stackActionImageViews: [UIImageView]!
    @IBOutlet var stackActionButtons: [UIButton]!
    @IBOutlet var stackActionLabels: [UILabel]!

    private var model: CREDCardModel?
    weak var delegate: CREDCardViewDelegate?
    private var state: CardState = .center

    func resetSwipeView() {
        state = .center
        UIView.animate(withDuration: 0.3) {
            self.swipeView.center = self.center
        }
    }

    func updateCardView(model: CREDCardModel) {
        self.model = model
        self.swipeView.center = self.center
        cardLabel.text = model.cardName
        self.updateStackActions()
    }

    func updateStackActions() {
        stackActionViews.forEach { $0.isHidden = true }
        if let actions = self.model?.actions {
            for i in 0..<actions.count {
                let label = stackActionLabels[i]
                label.text = actions[i]
                let imageView = stackActionImageViews[i]
                if #available(iOS 13.0, *) {
                    imageView.image = UIImage(systemName: String(actions[i].split(separator: " ").first ?? ""))
                } else {
                    // Fallback on earlier versions
                }
                let view = stackActionViews[i]
                view.isHidden = false
                let button = stackActionButtons[i]
                button.tag = i
                button.addTarget(self, action: #selector(cardActionTap(sender:)), for: .touchUpInside)
            }
        }
    }

    @objc func cardActionTap(sender: UIButton) {
        if let actions = self.model?.actions {
            let name = actions[sender.tag]
            self.delegate?.selectedAction(name: name)
        }
    }

}

extension CREDCardView: UIGestureRecognizerDelegate {

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        let velocity = panRecognizer.velocity(in: self)

        if abs(velocity.y) > abs(velocity.x) {
            return false
        }

        return true
    }

    @IBAction func panGestureHandler(_ recognizer: UIPanGestureRecognizer) {
        self.delegate?.resetLastSwipedCard(model: model)
        let translation = recognizer.translation(in: self)

        if self.swipeView.frame.origin.x > 0 {
            if self.swipeView.center.x >= self.center.x {
                let x = stackHolderView.frame.width / 2
                self.stackHolderView.center = CGPoint(x: x, y: self.center.y)
            }
        } else {
            if self.swipeView.center.x <= self.center.x {
                let x = self.frame.maxX - (stackHolderView.frame.width / 2)
                self.stackHolderView.center = CGPoint(x: x, y: self.center.y)
            }
        }

        self.swipeView.center = CGPoint(x: self.swipeView.center.x + translation.x, y: self.swipeView.center.y)
        recognizer.setTranslation(CGPoint.zero, in: self)

        if self.swipeView.frame.origin.x >= self.frame.width / 2 {
            self.swipeView.center = CGPoint(x: self.center.x + self.frame.width / 2, y: self.swipeView.center.y)
            state = .left
            model?.isSwiped = true
            return
        }
        if self.swipeView.frame.origin.x <= -(self.frame.width / 2) {
            self.swipeView.center = CGPoint(x: self.center.x - self.frame.width / 2, y: self.swipeView.center.y)
            model?.isSwiped = true
            state = .right
            return
        }

        if recognizer.state == .ended {
            model?.isSwiped = false
            var x = self.center.x
            switch state {
            case .center:
                if self.swipeView.frame.origin.x > 20 {
                    x += self.frame.width / 2
                    model?.isSwiped = true
                    state = .left
                } else if self.swipeView.frame.origin.x < -20 {
                    x -= self.frame.width / 2
                    model?.isSwiped = true
                    state = .right
                }

            default:
                x = self.center.x
                state = .center
            }
            UIView.animate(withDuration: 0.2) {
                self.swipeView.center = CGPoint(x: x, y: self.swipeView.center.y)
            }
        }
    }

    func showFirstRun() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3, animations: {
                self.swipeView.center = CGPoint(x: self.center.x - self.frame.width / 2, y: self.swipeView.center.y)
            }) { (completed) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    UIView.animate(withDuration: 0.3) {
                        self.swipeView.center = CGPoint(x: self.center.x, y: self.swipeView.center.y)
                    }
                }
            }
        }
    }

}

extension UIView {

    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil).first as? UIView
    }

}
