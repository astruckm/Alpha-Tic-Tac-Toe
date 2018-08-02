
import Foundation

let squaresPerSide = 3 //TODO: put in GameBoard

class GameBoard {
    let totalNumSquares: Int
    
    //Single instance of allSquares for Game to track
    var squares: [Square]
    
    init(numSquaresPerSide squaresPerSide: Int) {
        totalNumSquares = Int(pow(Double(squaresPerSide), 2))
        squares = Square.getAllSquares(numSquaresPerSide: squaresPerSide)
    }
    
}
