
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
    let players: [Player] = [.computer, .human]
    
    var winner: Player?
    var playerWhoseTurnItIs: Player
    var isXsTurn = false
    var turnsPlayed = 0
    var gameIsInProgress: Bool {
        get {
            return turnsPlayed < gameResult.numTotalSquares && winner == nil
        } set { }
    }
    var tracksGameStateDelegate: TracksGameState?
    
    //MARK: Initialization
    init(playerWithFirstMove: Player) {
        //TODO: This should maybe initialize the player and isXsTurn properties, perhaps many more
        self.playerWhoseTurnItIs = playerWithFirstMove
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
    
    private func move(atSquare square: Square) {
        guard square.state == .empty else { return }
        
        let sideTapped: Square.State = isXsTurn == true ? .x : .o
        gameBoard.squares[square.position.rawValue].state = sideTapped
        gameResult.checkForWinner(ofGame: gameBoard, sidePlayed: sideTapped, atSquare: square, currentPlayer: playerWhoseTurnItIs)
        winner = gameResult.winner
        
        let newSquare = Square(position: square.position, state: sideTapped)
        tracksGameStateDelegate?.playedSquares.append(newSquare)
        isXsTurn.toggle()
        turnsPlayed += 1
    }
    
}






