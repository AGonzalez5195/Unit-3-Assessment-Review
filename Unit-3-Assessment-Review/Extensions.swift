//
//  Extensions.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

extension Sequence {
    var joinedStringFromArray: String {
        return map { "\($0)" }.joined(separator: ", ")
    }
}
