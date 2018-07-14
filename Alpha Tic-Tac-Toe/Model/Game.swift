//
//  Game.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

//protocol TracksGameState?

class Game {
    let gameBoard = GameBoard()
    var winner: Side?
    var isXsTurn = false //should this be isPlayersTurn?
    var turnsPlayed = 0
    var gameIsInProgress: Bool {
        get {
            return turnsPlayed < 9
        } set { }
    }
    //var squaresStillEmpty: [Square] = gameBoard.allSquares...within an init()
    let computer: AI
    
    init() {
        self.computer = AI(gameBoard: gameBoard)
    }
    
    deinit {
        print("Game ended")
    }
    
    //TODO: init method called upon Start button being tapped
    
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
//        if let square = Square(rawValue: playedSquareRawIndex, state: <#Square.State#>), gameBoard.squareStates[square.row][square.column] == .empty {
//            move(atSquare: square)
//            print("Computer takes \(square)")
//        }
    }
    
    private func move(atSquare square: Square) {
        //Call func again if square is already tapped
        guard square.state == .empty else {
            move(atSquare: square)
            return
        }
        
        let tappedIcon: Square.State = isXsTurn == true ? .x : .o
        gameBoard.squares[square.position.rawValue].state = tappedIcon
        checkForWinner(sidePlayed: tappedIcon, withSquare: square)
        
        isXsTurn.toggle()
        turnsPlayed += 1
    }
    
    private func checkForWinner(sidePlayed side: Square.State, withSquare square: Square) {
        //check square's row, column, and diagonal
        let columnSquares = gameBoard.squares.filter { $0.column == square.column }
        let rowSquares = gameBoard.squares.filter { $0.row == square.row }
        let diagonalSquares: [Square]
        if square.isOnDiagonalLR {
            diagonalSquares = gameBoard.squares.filter{ $0.column == $0.row }
        } else if square.isOnDiagonalRL {
            diagonalSquares = gameBoard.squares.filter{ $0.column + $0.row == 2 }
        } else {
            diagonalSquares = []
        }
        
        checkLineForWinner(side, withLine: columnSquares)
        checkLineForWinner(side, withLine: rowSquares)
        checkLineForWinner(side, withLine: diagonalSquares)
    }
    
    private func checkLineForWinner(_ side: Square.State, withLine squares: [Square]) {
        var counter = 0
        for square in squares {
            if square.state != side { return }
            counter += 1
            if counter == 3 {
                declareWinner(forSide: square.state)
            }
        }
    }
    
    private func declareWinner(forSide side: Square.State) {
        print("\(side) is the winner!")
        gameIsInProgress = false
        //TODO: terminate game
    }
}

class GameResult {
    var consecutiveSquares = 1
    var pairs: [(Square, Square)] = []
    
    func addPair(to tappedSquare: Square) {
        //Pairs: same row or column, and abs difference of 1 for the other
        //OR contains .midMid and another square
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

