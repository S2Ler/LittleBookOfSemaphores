import Foundation
import SemaphorToolkit

// 3.8
final class Queue_3_8_2_Task: Task {
  let name: String = "Queue 3.8.2"
  private var followers: Int = 0
  private var leaders: Int = 0
  private var mutex = Sem(value: 1)
  private let leader = Sem(value: 0)
  private let follower = Sem(value: 0)
  private let dance = Sem(value: 0)

  func perform(display: Display) {
    let pairsCount = 4

    display.show("Starting")
    for idx in 0..<pairsCount {
      DispatchQueue.global().async {
        self.sendLeader(display: display, idx: idx)
      }
    }
    for idx in 0..<pairsCount {
      DispatchQueue.global().async {
        self.sendFollower(display: display, idx: idx)
      }
    }
  }

  private func sendLeader(display: Display, idx: Int) {
    display.show("Leader #\(idx) arrived")
    mutex.wait()
    if followers > 0 {
      followers -= 1
      display.show("Leader #\(idx) found a follower")
      follower.signal()
    }
    else {
      leaders += 1
      mutex.signal()
      display.show("Leader #\(idx) waiting for a follower")
      leader.wait()
    }
    display.show("Dance (leader) #\(idx)")
    dance.wait()
    display.show("Dance #\(idx) finished")
    mutex.signal()
  }

  private func sendFollower(display: Display, idx: Int) {
    display.show("Follower #\(idx) arrived")
    mutex.wait()
    if followers > 0 {
      followers -= 1
      display.show("Follower #\(idx) found a leader")
      leader.signal()
    }
    else {
      followers += 1
      mutex.signal()
      follower.wait()
    }
    display.show("Dance (follower) #\(idx)")
    dance.signal()
  }
}
