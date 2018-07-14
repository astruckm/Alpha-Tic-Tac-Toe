//
//  Extensions+Helpers.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

extension Bool {
    public mutating func toggle() {
        self = self == true ? false : true
    }
}
