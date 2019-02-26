import Foundation

final class TurnstileTask: Task {
    let name: String = "Turnstile"

    func perform(display: Display) {
        let numberOfThreads = 4

        let turnstile = DispatchSemaphore(value: 0)
        let turnstile2 = DispatchSemaphore(value: 1)
        let countMutex = DispatchSemaphore(value: 1)
        var count: Int = 0

        for threadNumber in 1...numberOfThreads {
            DispatchQueue.global().async {
                for _ in 0..<5 {
                    display.show("Thread \(threadNumber)")
                    countMutex.wait()
                    count += 1
                    if count == numberOfThreads {
                        display.show("Open turnstile")
                        turnstile2.wait()
                        turnstile.signal()
                    }
                    countMutex.signal()

                    turnstile.wait()
                    turnstile.signal()
                    display.show("Critical point on thread \(threadNumber)")

                    countMutex.wait()
                    count -= 1
                    if count == 0 {
                        turnstile.wait()
                        turnstile2.signal()
                        display.show("Locked turnstile")
                    }
                    countMutex.signal()

                    turnstile2.wait()
                    turnstile2.signal()
                }
            }
        }
    }
}
