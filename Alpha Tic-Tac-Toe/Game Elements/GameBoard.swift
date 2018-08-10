
import Foundation

let squaresPerSide = 3 //TODO: put in GameBoard

//Assuming this is a square game board
class GameBoard {
    let squaresPerSide: Int
    let totalNumSquares: Int
    var squares: [Square] = [] ///Single instance of allSquares for Game to track

    
    init(numSquaresPerSide squaresPerSide: Int) {
        self.squaresPerSide = squaresPerSide
        totalNumSquares = Int(pow(Double(squaresPerSide), 2))
        for position in 0..<totalNumSquares {
            squares.append(Square(positionIndex: position, totalNumSquares: totalNumSquares, state: .empty))
        }
    }
    
    //MARK: Methods
    static func getRow(ofPosition index: Int, numSquaresPerSide: Int) -> Int {
        return index / numSquaresPerSide
    }
    
    static func getColumn(ofPosition index: Int, numSquaresPerSide: Int) -> Int {
        return index % numSquaresPerSide
    }
    
    static func isOnDiagonalLR(ofPosition positionIndex: Int, numSquaresPerSide: Int) -> Bool {
        let row = self.getRow(ofPosition: positionIndex, numSquaresPerSide: numSquaresPerSide)
        let column = self.getColumn(ofPosition: positionIndex, numSquaresPerSide: numSquaresPerSide)
        return (row == column) && (numSquaresPerSide % 2 == 1)
    }
    
    static func isOnDiagonalRL(ofPosition positionIndex: Int, numSquaresPerSide: Int) -> Bool {
        let row = self.getRow(ofPosition: positionIndex, numSquaresPerSide: numSquaresPerSide)
        let column = self.getColumn(ofPosition: positionIndex, numSquaresPerSide: numSquaresPerSide)
        return (row + column == (numSquaresPerSide-1)) && (numSquaresPerSide % 2 == 1)
    }

    
}
