//
//  GameBoard.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/12/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

class GameBoard {
    //Single instance of allSquares for Game to track
    //Is a var to allow changing its state
    var squares: [Square] = Square.allSquares
}
