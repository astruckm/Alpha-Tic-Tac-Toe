//
//  Game.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

enum Square: Int, Hashable {
    case topLeft, topMid, topRight, midLeft, midMid, midRight, bottomLeft, bottomMid, bottomRight
    
    enum State {
        case empty
        case x
        case o
    }
}

class GameResult {
}

class PlayGame {
    let gameBoard = GameResult()
    var isXsTurn = false
    
    //Represent squares as 2x2 array
    var stateOfSquares: [[Square.State]] = [[.empty, .empty, .empty], [.empty, .empty, .empty], [.empty, .empty, .empty]]
    
    func squareTapped(at square: Square) {
        let squareIndex: (row: Int, column: Int) = (square.rawValue/3, square.rawValue%3)
        
        //Do nothing if square is already tapped
        let tappedSquareState = stateOfSquares[squareIndex.row][squareIndex.column]
        guard tappedSquareState == .empty else { return }
        
        let tappedIcon: Square.State = isXsTurn == true ? .x : .o
        stateOfSquares[squareIndex.row][squareIndex.column] = tappedIcon
    }

    //TODO: Logic for when game ends: choose winner OR end game
}
