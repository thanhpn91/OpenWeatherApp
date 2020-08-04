//
//  UITableViewCell+Identifier.swift
//  Weather
//
//  Created by Thanh Pham on 8/3/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
