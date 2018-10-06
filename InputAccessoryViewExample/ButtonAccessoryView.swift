//
//  ButtonAccessoryView.swift
//  InputAccessoryViewExample
//
//  Created by Rohit Pal on 06/10/18.
//  Copyright © 2018 Rohit Pal. All rights reserved.
//

import UIKit
final class ButtonAccessoryView: UIView {
    @IBOutlet weak var actionButton: UIButton!
    static func getView(target: UIViewController, actionName: String, action: Selector) -> ButtonAccessoryView? {
        let nib = ButtonAccessoryView.nib()
        if let view = nib?.instantiate(withOwner: target, options: nil).first as?
            ButtonAccessoryView {
            view.actionButton.setTitle(actionName, for: .normal)
            view.actionButton.addTarget(target, action: action, for: .touchUpInside)
            return view
        } else {
            return nil
        }
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize.init(width: size.width, height: 64)
    }

    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.invalidateIntrinsicContentSize()
    }
}


extension ButtonAccessoryView: NibLoadable {
    static var NibName: String {
        return "ButtonAccessoryView"
    }
}
