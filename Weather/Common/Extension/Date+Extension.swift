//
//  Date+Extension.swift
//  Weather
//
//  Created by Thanh Pham on 8/3/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import UIKit

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
