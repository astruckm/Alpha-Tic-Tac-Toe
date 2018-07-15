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
    private var playedSquaresPositions: [Square.Position] { return playedSquaresSet.map {$0.position} }
    
    private var playedSquaresFirstRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 0} }
    private var playedSquaresSecondRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 1} }
    private var playedSquaresThirdRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 2} }
    private var playedSquaresFirstColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 0} }
    private var playedSquaresSecondColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 1} }
    private var playedSquaresThirdColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 2} }
    private var playedSquaresOnDiagonalLR: [Square] { return playedSquaresSet.filter{$0.isOnDiagonalLR} }
    private var playedSquaresOnDiagonalRL: [Square] { return playedSquaresSet.filter{$0.isOnDiagonalRL} }

    private var threateningPairs: [(Square, Square)] = []
    private var winnablePairs: [(Square, Square)] = []

    func updateImportantPairs() {
        threateningPairs = []
        winnablePairs = []
        let rowsColumnsDiagonals = [playedSquaresFirstRow, playedSquaresSecondRow, playedSquaresThirdRow, playedSquaresFirstColumn, playedSquaresSecondColumn, playedSquaresThirdColumn, playedSquaresOnDiagonalLR, playedSquaresOnDiagonalRL]
        for line in rowsColumnsDiagonals {
            if line.count == 2 {
                if line[0].state == line[1].state && line[0].state == side.adversary {
                    threateningPairs.append((line[0], line[1]))
                } else if line[0].state == line[1].state && line[0].state == side {
                    winnablePairs.append((line[0], line[1]))
                }
            }
        }
        print("Number of threatening pairs: \(threateningPairs.count)")
        print("Number of winnable pairs: \(winnablePairs.count)")
    }
    
    init(playingAsX: Bool) {
        self.playingAsX = playingAsX
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
    
    func playNextMoves() -> Square.Position {
        if !winnablePairs.isEmpty {
            let winnablePair = winnablePairs[0]
            return fillOutImportantPair(winnablePair)
        }
        if !threateningPairs.isEmpty {
            let threateningPair = threateningPairs[0]
            return fillOutImportantPair(threateningPair)
        }
        
        return playRandomOptimalSquare()
    }
    
    private func fillOutImportantPair(_ pair: (Square, Square)) -> Square.Position {
        guard !threateningPairs.isEmpty else {
            print("blockOpponentsPair called erroneously")
            return .topLeft
        }
        
        let squareRawValue: Int
        let sumOfPairsRawValues = pair.0.position.rawValue + pair.1.position.rawValue
        //figure out total sum of rawValues in line, then subtract to get missing
        if pair.0.row == pair.1.row {
            squareRawValue = (((pair.0.row * squaresPerSide) + 1) * squaresPerSide) - sumOfPairsRawValues
        } else if pair.0.column == pair.1.column {
            squareRawValue = ((pair.0.column + squaresPerSide) * squaresPerSide) - sumOfPairsRawValues
        } else if (pair.0.isOnDiagonalLR && pair.1.isOnDiagonalLR) || pair.0.isOnDiagonalRL && pair.1.isOnDiagonalRL {
            squareRawValue = 12 - sumOfPairsRawValues
        } else {
            print("Error finding threateningPair to block!")
            squareRawValue = 0
        }
        guard let squareToBlock = Square.Position(rawValue: squareRawValue) else {
            print("squareToBlock calculated incorrectly")
            return .topLeft
        }
        return squareToBlock
    }
    
    //Run random number generator until it creates a winnable pair that is in same row or column as adversary
    private func playRandomOptimalSquare() -> Square.Position {
        while true {
            let random = Int(arc4random_uniform(9))
            let position = Square.Position(rawValue: random)!
            
            if !playedSquaresPositions.contains(position)  {
                let possibleSquare = Square(position: position, state: side)
                var tempPlayedSquares = playedSquaresSet
                
                
                return position
            }
        }
    }

    
    //Otherwise, make its own pair
    //Always win if computer's potential 3rd square from a pair is .empty
    
}
