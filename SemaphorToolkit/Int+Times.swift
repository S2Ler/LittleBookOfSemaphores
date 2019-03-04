import Foundation

public extension Int {
    func times(_ block: () -> Void) {
        for _ in 0..<self {
            block()
        }
    }
}
