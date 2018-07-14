//
//  DrawBoard.swift
//  Alpha Tic-Tac-To
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import UIKit

extension UIView {
    func createTicTacToeBoard() {
        let firstVerticalLine = CALayer()
        let secondVerticalLine = CALayer()
        let firstHorizontalLine = CALayer()
        let secondHorizontalLine = CALayer()
        
        firstVerticalLine.borderColor = UIColor.black.cgColor
        secondVerticalLine.borderColor = UIColor.black.cgColor
        firstHorizontalLine.borderColor = UIColor.black.cgColor
        secondHorizontalLine.borderColor = UIColor.black.cgColor
        firstVerticalLine.borderWidth = 1
        secondVerticalLine.borderWidth = 1
        firstHorizontalLine.borderWidth = 1
        secondHorizontalLine.borderWidth = 1
        
        firstVerticalLine.frame = CGRect(x: self.bounds.width/3, y: self.bounds.minY, width: 1, height: self.bounds.height)
        secondVerticalLine.frame = CGRect(x: (self.bounds.width/3)*2, y: self.bounds.minY, width: 1, height: self.bounds.height)
        firstHorizontalLine.frame = CGRect(x: self.bounds.minX, y: self.bounds.height/3, width: self.bounds.width, height: 1)
        secondHorizontalLine.frame = CGRect(x: self.bounds.minX, y: ((self.bounds.height/3)*2), width: self.bounds.width, height: 1)
        
        self.layer.addSublayer(firstVerticalLine)
        self.layer.addSublayer(secondVerticalLine)
        self.layer.addSublayer(firstHorizontalLine)
        self.layer.addSublayer(secondHorizontalLine)
    }
}
