//
//  ChatAccessoryView.swift
//  InputAccessoryViewExample
//
//  Created by Rohit Pal on 24/08/18.
//  Copyright © 2018 Rohit Pal. All rights reserved.
//

import UIKit

final class ChatAccessoryView: UIView {
    static let maxHeight: CGFloat = 125.0
    static let minHeight: CGFloat = 49.0
    static let paddingTop: CGFloat = 8.0
    static let paddingBottom: CGFloat = 8.0
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var textView: UITextView!
    static func getView(target: UIViewController, text: String? = nil, placeholder: String? = "Type a message",
                        actionName: String, action: Selector) -> ChatAccessoryView? {
        let nib = ChatAccessoryView.nib()
        if let view = nib?.instantiate(withOwner: target, options: nil).first as?
            ChatAccessoryView {
            view.actionButton.setTitle(actionName, for: .normal)
            view.actionButton.addTarget(target, action: action, for: .touchUpInside)
            view.placeholder.text = placeholder
            view.textView.delegate = view.self
            if text != nil, text?.isEmpty == false {
                view.placeholder.isHidden = true
                view.textView.text = text
            }
            return view
        } else {
            return nil
        }
    }

    override var intrinsicContentSize: CGSize {
        self.textView.isScrollEnabled = false
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat(MAXFLOAT)))
        let totalHeight = size.height + ChatAccessoryView.paddingTop + ChatAccessoryView.paddingBottom
        if totalHeight <= ChatAccessoryView.maxHeight {
            return CGSize(width: self.bounds.width, height: max(totalHeight, ChatAccessoryView.minHeight))
        } else {
            self.textView.isScrollEnabled = true
            return CGSize(width: self.bounds.width, height: ChatAccessoryView.maxHeight)
        }
    }
}

extension ChatAccessoryView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        showHidePlaceholder(in: textView)
    }

    func textViewDidChange(_ textView: UITextView) {
        self.invalidateIntrinsicContentSize()
        updateConstraints()
        showHidePlaceholder(in: textView)
    }

    func showHidePlaceholder(in textView: UITextView) {
        if !textView.hasText || textView.text.isEmpty {
            // show placeholder Label
            placeholder?.isHidden = false
        } else {
            // hide
            placeholder?.isHidden = true
        }
    }
}

extension ChatAccessoryView: NibLoadable {
    static var NibName: String {
        return "ChatAccessoryView"
    }
}
