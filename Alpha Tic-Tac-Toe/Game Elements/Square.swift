
import Foundation


//This is the base object, from which the game board and its state is created
struct Square: Hashable, Equatable {
    let positionIndex: Int
    let position: Position
    var state: State
    
    //All of these should go in GameBoard??? (Square shouldn't know about it's position)
    var row: Int { return position.rawValue / squaresPerSide }
    var column: Int { return position.rawValue % squaresPerSide }
    var isOnDiagonalLR: Bool { return (self.row == self.column) && (squaresPerSide % 2 == 1) }
    var isOnDiagonalRL: Bool { return (self.row + self.column == (squaresPerSide-1)) && (squaresPerSide % 2 == 1) }

    init(positionIndex: Int, totalNumSquares: Int, state: State) {
        if positionIndex > totalNumSquares || positionIndex < 0 {
            self.positionIndex = positionIndex % totalNumSquares
        } else {
            self.positionIndex = positionIndex
        }
        self.state = state
        
        self.position = Position(rawValue: positionIndex)!
    }
    
    //************************************************
    @available(*, deprecated: 1.0)
    enum Position: Int, Hashable {
        case topLeft, topMid, topRight, midLeft, midMid, midRight, bottomLeft, bottomMid, bottomRight
        static var allPositions: [Position] = [.topLeft, .topMid, .topRight, .midLeft, .midMid, .midRight, .bottomLeft, .bottomMid, .bottomRight]
        
        static func == (lhs: Position, rhs: Position) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
    //************************************************
    
    enum State: String, Equatable, Hashable {
        case empty, x, o
        
        var adversary: State? {
            switch self {
            case .empty: return nil
            case .x: return .o
            case .o: return .x
            }
        }
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
    
    static func == (lhs: Square, rhs: Square) -> Bool {
        return (lhs.positionIndex == rhs.positionIndex) && (lhs.state == rhs.state)
    }
    
        
}




