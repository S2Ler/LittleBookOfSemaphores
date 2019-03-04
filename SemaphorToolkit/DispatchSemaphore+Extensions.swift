import Foundation

public extension DispatchSemaphore {
    func signal(nTimes n: Int) {
        n.times {
            self.signal()
        }
    }
}
