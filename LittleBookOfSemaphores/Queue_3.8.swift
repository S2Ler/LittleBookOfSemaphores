import Foundation
import SemaphorToolkit

// 3.8
final class Queue_3_8_Task: Task {
  let name: String = "Queue 3.8"
  private let leader = Sem(value: 0)
  private let follower = Sem(value: 0)

  func perform(display: Display) {
    let pairsCount = 4

    display.show("Starting")
    DispatchQueue.global().async {
      for idx in 0..<pairsCount {
        self.sendLeader(display: display, idx: idx)
      }
    }
    DispatchQueue.global().async {
      for idx in 0..<pairsCount {
        self.sendFollower(display: display, idx: idx)
      }
    }
  }

  private func sendLeader(display: Display, idx: Int) {
    display.show("Leader #\(idx) arrived")
    leader.signal()
    follower.wait()
    display.show("Leader #\(idx) found follower")
  }

  private func sendFollower(display: Display, idx: Int) {
    display.show("Follower #\(idx) arrived")
    follower.signal()
    leader.wait()
    display.show("Follower #\(idx) found leader")
  }
}
