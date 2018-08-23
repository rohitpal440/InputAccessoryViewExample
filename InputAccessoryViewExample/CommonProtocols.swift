//
//  CommonProtocols.swift
//  InputAccessoryViewExample
//
//  Created by Rohit Pal on 24/08/18.
//  Copyright © 2018 Rohit Pal. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var NibName: String { get }
}

extension NibLoadable {
    static func nib() -> UINib? {
        if NibName.count > 0 {
            return UINib(nibName: NibName, bundle: nil)
        } else {
            return nil
        }
    }
}
