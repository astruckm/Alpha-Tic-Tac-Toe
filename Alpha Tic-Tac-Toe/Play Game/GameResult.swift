
import Foundation

class GameResult {
    
    var winner: Player? ///Optional initialized as nil. If nil when game ends: tie game.
    var numTotalSquares: Int { return Int(pow(Double(squaresPerSide), 2)) }
    

    func checkForWinner(ofGame gameBoard: GameBoard, sidePlayed side: Square.State, atSquare square: Square, currentPlayer: Player) {
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
        
        for line in [columnSquares, rowSquares, diagonalSquares] {
            checkLineForWinner(side, currentPlayer: currentPlayer, withLine: line)
        }
    }
    
    private func checkLineForWinner(_ side: Square.State, currentPlayer: Player, withLine squares: [Square]) {
        var counter = 0
        for square in squares {
            if square.state != side { return }
            counter += 1
            if counter == 3 {
                declareWinner(player: currentPlayer, forSide: square.state)
            }
        }
    }
    
    private func declareWinner(player: Player, forSide side: Square.State) {
        print("\(side) is the winner!")
        winner = player
    }
    
}






