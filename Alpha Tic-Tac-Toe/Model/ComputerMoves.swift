//
//  AI.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

class ComputerMoves {
    var playingAsX: Bool
    
    init(playingAsX: Bool) {
        self.playingAsX = playingAsX
    }
    
    func playRandomSquareAtIndex() -> Int {
        return Int(arc4random_uniform(9))
    }
    
    //These types of moves funs return only Square.Position values, as States are inaccessible to AI
    //First move is in the center or otherwise in a corner
    func playFirstMove(humanMove: Square?) -> Square.Position {
        if let previousMove = humanMove, previousMove.position != .midMid {
            return .midMid
        }
        
        let random = Int(arc4random_uniform(4))
        let squarePositionRawValue = (random + (random / 2)) * 2
        if let position = Square.Position(rawValue: squarePositionRawValue) {
            return position
        }
        
        print("\nCould not initialize correct Square!\n")
        return .topLeft
    }
    
//    func blockOpponentsPair() -> Square {
//        
//    }
    
    func playNextMoves() -> (rowIndex: Int, columnIndex: Int) {
        
        
        return (-1, -1)
    }
    
    //Always block a pair of opponent's squares if potential 3rd square is .empty
    //Otherwise, make its own pair
    //Always win if computer's potential 3rd square from a pair is .empty
    
}
