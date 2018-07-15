//
//  AI.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

class ComputerMoves: TracksGameState {
    let playingAsX: Bool
    var side: Square.State { return playingAsX ? .x : .o }
    
    var playedSquares: [Square] = []
    private var playedSquaresSet: Set<Square> { return Set(playedSquares) } //No duplicates
    
    //Are these necessary?
    private var playedSquaresPositions: [Square.Position] { return playedSquaresSet.map {$0.position} }
    private var playedSquaresIndices: [Int] { return playedSquaresPositions.map({$0.rawValue})}
    
    private var playedSquaresFirstRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 0} }
    private var playedSquaresSecondRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 1} }
    private var playedSquaresThirdRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 2} }
    private var playedSquaresFirstColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 0} }
    private var playedSquaresSecondColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 1} }
    private var playedSquaresThirdColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 2} }
    private var playedSquaresOnDiagonalLR: [Square] { return playedSquaresSet.filter{$0.isOnDiagonalLR} }
    private var playedSquaresOnDiagonalRL: [Square] { return playedSquaresSet.filter{$0.isOnDiagonalRL} }

    var threateningPairs: [(Square, Square)] = [] //This could be computed based on above??
    
    func updateThreateningPairs() {
        threateningPairs = []
        let rowsColumnsDiagonals = [playedSquaresFirstRow, playedSquaresSecondRow, playedSquaresThirdRow, playedSquaresFirstColumn, playedSquaresSecondColumn, playedSquaresThirdColumn, playedSquaresOnDiagonalLR, playedSquaresOnDiagonalRL]
        for line in rowsColumnsDiagonals {
            if line.count == 2 {
                if line[0].state == line[1].state && line[0].state == side.adversary {
                    threateningPairs.append((line[0], line[1]))
                }
            }
        }
    }
    
    init(playingAsX: Bool) {
        self.playingAsX = playingAsX
    }
    
    func playRandomSquareAtIndex() -> Int {
        while true {
            let random = Int(arc4random_uniform(9))
            if !playedSquaresIndices.contains(random) {
                return random
            }
        }
    }
    
    //These types of moves funs return only Square.Position values, as whole board is inaccessible to AI
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

    
    //Always block a pair of opponent's squares if potential 3rd square is .empty
    //Otherwise, make its own pair
    //Always win if computer's potential 3rd square from a pair is .empty
    
}
