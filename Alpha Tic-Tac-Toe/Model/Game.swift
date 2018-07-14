//
//  Game.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

protocol TracksGameState {
    var playedSquares: [Square] { get set }
}

class Game {
    let gameBoard = GameBoard()
    let computer = ComputerMoves(playingAsX: true)
    var winner: Square.State?
    var isXsTurn = false //should this be isPlayersTurn?
    var turnsPlayed = 0
    var gameIsInProgress: Bool {
        get {
            return turnsPlayed < 9
        } set { }
    }
    var tracksGameStateDelegate: TracksGameState?
    
    init() {
        tracksGameStateDelegate = computer
    }
    
    deinit {
        print("Game ended")
    }
    
    //TODO: init method called upon Start button being tapped
    
    func humanMove(atSquare square: Square) {
        move(atSquare: square)
        guard gameIsInProgress == true else { return }
        computerMove()
    }
    
    func computerMove() {
        guard winner == nil else { return }
        if turnsPlayed <= 1 {
            let firstMove: Square? = tracksGameStateDelegate?.playedSquares.first
            let computerFirstMovePosition = computer.playFirstMove(humanMove: firstMove)
            let computerFirstMove = gameBoard.squares[computerFirstMovePosition.rawValue]
            move(atSquare: computerFirstMove)
            print("Computer's first move is at: \(computerFirstMove.position)")
            return
        }
        let squareIndex = computer.playRandomSquareAtIndex()
        let square = gameBoard.squares[squareIndex]
        move(atSquare: square)
        print("Computer takes: \(square.position)")        
    }
    
    private func move(atSquare square: Square) {
        //Need to call func again if square is already tapped
        guard square.state == .empty else { return }
        
        let tappedIcon: Square.State = isXsTurn == true ? .x : .o
        gameBoard.squares[square.position.rawValue].state = tappedIcon
        checkForWinner(sidePlayed: tappedIcon, withSquare: square)
        
        tracksGameStateDelegate?.playedSquares.append(square)
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
            print("counter is \(counter)")
            if counter == 3 {
                declareWinner(forSide: square.state)
            }
        }
    }
    
    private func declareWinner(forSide side: Square.State) {
        print("\(side) is the winner!")
        gameIsInProgress = false
        winner = side
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




