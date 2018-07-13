//
//  AI.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

class AI {
    let gameBoard: GameBoard
    let rawSquareIndex = arc4random_uniform(9)
    
    init(gameBoard: GameBoard) {
        self.gameBoard = gameBoard
    }
    
    func playRandomSquareAt() -> (rowIndex: Int, columnIndex: Int) {
        return (Int(rawSquareIndex / 3), Int(rawSquareIndex % 3))
    }
    
    //First move is in the center or otherwise in a corner
    func playFirstMove() -> (rowIndex: Int, columnIndex: Int) {
        if gameBoard.squareStates[1][1] == .empty {
            return (1, 1)
        }
        
        let random = arc4random_uniform(4)
        return (Int((random/2) * 2), Int((random%2) * 2))
    }
    
//    func blockOpponentsPair() -> Square {
//        
//    }
    
    func playNextMoves() -> (rowIndex: Int, columnIndex: Int) {
        gameBoard
        
        return (-1, -1)
    }
    
    //How to make it never lose:
    //Always block a pair of opponent's squares if potential 3rd square is .empty
    //Otherwise, make its own pair
    //Always win if computer's potential 3rd square from a pair is .empty
    
}
