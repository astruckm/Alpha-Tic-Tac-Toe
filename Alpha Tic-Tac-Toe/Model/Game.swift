
import Foundation

protocol TracksGameState {
    var playedSquares: [Square] { get set }
}

//Play the game
class Game {
    //MARK: Properties
    let gameBoard = GameBoard()
    let gameResult = GameResult()
    let computer = ComputerMoves(playingAsX: true)
    var winner: Square.State?
    var isXsTurn = false
    var turnsPlayed = 0
    var gameIsInProgress: Bool {
        get {
            return turnsPlayed < 9
        } set { }
    }
    var tracksGameStateDelegate: TracksGameState?
    
    //MARK: Initialization
    init() {
        tracksGameStateDelegate = computer
    }
    
    //MARK: Methods called to play game
    func humanMove(atSquare square: Square) {
        move(atSquare: square)
        guard gameIsInProgress == true else { return }
        computer.updateImportantPairs()
        computerMove()
    }
    
    func computerMove() {
        guard winner == nil else { return }
        if turnsPlayed <= 1 {
            let firstMove: Square? = tracksGameStateDelegate?.playedSquares.first
            let computerFirstMovePosition = computer.playFirstMove(humanMove: firstMove)
            let computerFirstMove = gameBoard.squares[computerFirstMovePosition.rawValue]
            move(atSquare: computerFirstMove)
            return
        }
        let squareIndex = computer.playNextMoves()
        let square = gameBoard.squares[squareIndex.rawValue]
        move(atSquare: square)
        computer.updateImportantPairs()
    }
    
    //MARK: Sub-methods
    private func move(atSquare square: Square) {
        guard square.state == .empty else { return }
        
        let sideTapped: Square.State = isXsTurn == true ? .x : .o
        gameBoard.squares[square.position.rawValue].state = sideTapped
        checkForWinner(sidePlayed: sideTapped, withSquare: square)
        
        let newSquare = Square(position: square.position, state: sideTapped)
        tracksGameStateDelegate?.playedSquares.append(newSquare)
        isXsTurn.toggle()
        turnsPlayed += 1
    }
    
    private func checkForWinner(sidePlayed side: Square.State, withSquare square: Square) {
        //check newly-played square's row, column, and diagonal
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
        winner = side
    }
}






