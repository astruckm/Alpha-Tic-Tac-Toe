
import Foundation

let squaresPerSide = 3

//This is the base object, from which the game board and its state is created
struct Square: Hashable, Equatable {
    enum Position: Int, Hashable {
        case topLeft, topMid, topRight, midLeft, midMid, midRight, bottomLeft, bottomMid, bottomRight
        static var allPositions: [Position] = [.topLeft, .topMid, .topRight, .midLeft, .midMid, .midRight, .bottomLeft, .bottomMid, .bottomRight]
        
        static func == (lhs: Position, rhs: Position) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
    
    //This type used for both the state of a Square and for the associated player in the game
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
        return (lhs.position == rhs.position) && (lhs.state == rhs.state)
    }
    
    let position: Position
    var state: State
    var row: Int { return position.rawValue / squaresPerSide }
    var column: Int { return position.rawValue % squaresPerSide }
    var isOnDiagonalLR: Bool { return self.row == self.column }
    var isOnDiagonalRL: Bool { return (self.row + self.column == 2) }
    
    static let allSquares: [Square] = {
        var squares: [Square] = []
        for position in Position.allPositions {
            squares.append(Square(position: position, state: .empty))
        }
        return squares
    }()
    
}
