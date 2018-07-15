
import Foundation

extension Bool {
    public mutating func toggle() {
        self = self == true ? false : true
    }
}
