import Foundation

public typealias Sem = DispatchSemaphore

public extension Sem {
    func signal(nTimes n: Int) {
        n.times {
            self.signal()
        }
    }
}
