//
//  Game.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

//protocol TracksGameState?
//class GameBoard?
//var name dissonance b/w "square state" and "side"


enum Side {
    case player
    case computer
}

class GameResult {
    var consecutiveSquares = 1
    var pairs: [(Square, Square)] = []
    
    func addPair(to tappedSquare: Square) {
        //Pairs: same row or column, and abs difference of 1 for the other
        //OR contains .midMid and another square
    }
}

class PlayGame {
    let gameResult = GameResult()
    let gameBoard = GameBoard()
    var gameIsInProgress = true
    var winner: Side?
    var isXsTurn = false //should this be isPlayersTurn?
    var turnsPlayed = 0
    //var squaresStillEmpty: [Square] = gameBoard.allSquares...within an init()
    //var stateOfSquares = gameBoard.squareState....within an init()
    let computer: AI
    
    init() {
        self.computer = AI(gameBoard: gameBoard)
    }
    
    //TODO: init method called upon Start button being tapped
    //TODO: deinit after game is over
    
    func humanMove(atSquare square: Square) {
        move(atSquare: square)
    }
    
    func computerMove() {
        let playedSquareRawIndices: (Int, Int)
        if turnsPlayed <= 1 {
            playedSquareRawIndices = computer.playFirstMove()
        } else {
            playedSquareRawIndices = computer.playNextMoves()
        }
        let playedSquareRawIndex = (playedSquareRawIndices.0 * 2) + playedSquareRawIndices.1
        print(playedSquareRawIndex)
        if let square = Square(rawValue: playedSquareRawIndex), gameBoard.squareStates[square.row][square.column] == .empty {
            move(atSquare: square)
            print("Computer takes \(square)")
        }
    }
    
    private func move(atSquare square: Square) {
        //Do nothing if square is already tapped
        let tappedSquareState = gameBoard.squareStates[square.row][square.column]
        guard tappedSquareState == .empty else { return }
        
        let tappedIcon: Square.State = isXsTurn == true ? .x : .o
        gameBoard.squareStates[square.row][square.column] = tappedIcon
        checkForWinner(sidePlayed: tappedIcon, withSquare: square)
        
        isXsTurn.toggle()
        turnsPlayed += 1
    }
    
    private func checkForWinner(sidePlayed side: Square.State, withSquare square: Square) {
        //check square's row and column
        //TODO: combine these loops
        let indexRange = 0...2
        for index in indexRange {
            if gameBoard.squareStates[square.row][index] != side { break }
            if index == 2 {
                print("\(side) is the winner!")
                gameIsInProgress = false
                return
            }
        }
        for index in indexRange {
            if gameBoard.squareStates[index][square.column] != side { break }
            if index == 2 {
                print("\(side) is the winner!")
                gameIsInProgress = false
                return
            }
        }
        //then check diagonals for winner: midMid is side; AND [0][0], [2][2] OR [0][2], [2][0] are side
        if gameBoard.squareStates[1][1] == side && ((gameBoard.squareStates[0][0] == side && gameBoard.squareStates[2][2] == side) || (gameBoard.squareStates[2][0] == side && gameBoard.squareStates[0][2] == side)) {
            print("\(side) is the winner!")
            gameIsInProgress = false
            return
        }
    }

}

//check if any column or row contains a winner
//let indexRange = 0...2
//for rowIndex in indexRange {
//    for columnIndex in indexRange {
//        if stateOfSquares[rowIndex][columnIndex] == side {
//            if columnIndex < 2 {
//                print("\(side) is the winner!")
//                return
//            }
//            continue
//        }
//        break
//    }
//}
//for columnIndex in indexRange {
//    for rowIndex in indexRange {
//        if stateOfSquares[rowIndex][columnIndex] == side {
//            if columnIndex < 2 {
//                print("\(side) is the winner!")
//                return
//            }
//            continue
//        }
//        break
//    }
//}

