
import Foundation

class GameBoard {
    //Single instance of allSquares for Game to track
    //Is a var to allow changing its state
    var squares: [Square] = Square.allSquares
}
