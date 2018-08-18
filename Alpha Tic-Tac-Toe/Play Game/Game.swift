
import Foundation

protocol TracksGameState {
    var playedSquares: [Square] { get set }
    var unplayedSquares: Set<Square> { get set }
}

//Play the game
class Game {
    //MARK: Properties
    let gameBoard = GameBoard(numSquaresPerSide: 3)
    let gameResult = GameResult()
    let computer = ComputerMoves(playingAsX: true)
    let players: [Player] = [.computer, .human]
    
    var winner: Player?
    var playerWhoseTurnItIs: Player
    var isXsTurn: Bool
    var movesPlayed = 0
    var gameIsInProgress: Bool {
        get {
            return movesPlayed < gameBoard.totalNumSquares && winner == nil
        }
    }
    var tracksGameStateDelegate: TracksGameState?
    
    //MARK: Initialization
    init(playerWithFirstMove: Player, isXsTurn: Bool) {
        self.playerWhoseTurnItIs = playerWithFirstMove
        self.isXsTurn = isXsTurn
        tracksGameStateDelegate = computer
        tracksGameStateDelegate?.unplayedSquares = Set(gameBoard.squares)
    }
    
    //MARK: Methods called to play game
    func humanMove(atSquare square: Square) {
        move(atSquare: square)
        guard gameIsInProgress == true else { return }
        computer.updateImportantPairs()
        computerMove()  ///TODO: should this be called here? what about human v. human?
    }
    
    func computerMove() {
        guard winner == nil else { return }
        if movesPlayed <= 1 {
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
    
    private func move(atSquare square: Square) {
        guard square.state == .empty else { return }
        
        let sideTapped: Square.State = isXsTurn == true ? .x : .o
        gameBoard.squares[square.positionIndex].state = sideTapped
        gameResult.checkForWinner(ofGame: gameBoard, sidePlayed: sideTapped, atSquare: square, currentPlayer: playerWhoseTurnItIs)
        winner = gameResult.winner
        
        let newSquare = Square(positionIndex: square.positionIndex, state: sideTapped)
        tracksGameStateDelegate?.playedSquares.append(newSquare)
        isXsTurn.toggle()
        movesPlayed += 1
    }
    
}






