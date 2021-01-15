import Foundation
import SemaphorToolkit

final class BarrierTask: Task {
  let name: String = "Barrier"

  func perform(display: Display) {
    let numberOfThreads = 4

    let barrier = Barrier(numberOfThreads)

    DispatchQueue.concurrentPerform(iterations: numberOfThreads) { (threadNumber) in
      func run() {
        display.show("Thread \(threadNumber)")
        barrier.wait()
        display.show("Critical point on thread \(threadNumber)")
      }

      run()
    }
  }
}
