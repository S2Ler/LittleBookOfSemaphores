import Foundation

public class Barrier {
    private let n: Int
    private var count: Int = 0
    private let mutex = DispatchSemaphore(value: 1)
    private let turnstile = DispatchSemaphore(value: 0)
    private let turnstile2 = DispatchSemaphore(value: 1)

    public init(_ n: Int) {
        self.n = n
    }

    public func phase1(){
        mutex.wait()
        count += 1
        if count == n {
            turnstile.signal(nTimes: n)
        }
        mutex.signal()
        turnstile.wait()
    }

    public func phase2() {
        mutex.wait()
        count -= 1
        if count == 0 {
            turnstile2.signal(nTimes: n)
        }
        mutex.signal()
        turnstile2.wait()
    }
    public func wait() {
        phase1()
        phase2()
    }
}
