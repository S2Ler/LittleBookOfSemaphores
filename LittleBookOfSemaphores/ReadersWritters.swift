import Foundation
import SemaphorToolkit

final class ReadersWriters: Task {
  let name: String = "ReadersWriters"
  var i = 0

  func perform(display: Display) {
    let readLightswitch = Lightswitch()
    let roomEmpty = DispatchSemaphore(value: 1)

    for i in 0..<5 {
      sendReaders(readSwitch: readLightswitch, display, roomEmpty)
      sendWriter(name: "\(i)", display, roomEmpty)
    }
  }

  private func sendReaders(readSwitch: Lightswitch,
                           _ display: Display,
                           _ roomEmpty: DispatchSemaphore) {
    func sendOneReader(name: String) {
      display.show("--> Reader Arrived: \(name)")
      readSwitch.lock(roomEmpty)
      display.show("Critical Reader: \(name)")
      readSwitch.unlock(roomEmpty)
      display.show("<-- Reader: \(name)")
    }

    for i in 0..<5 {
      let name = "\(i + self.i)"
      DispatchQueue.global().async {
        sendOneReader(name: name)
      }
    }
    self.i += 5
  }

  private func sendWriter(name: String, _ display: Display, _ roomEmpty: DispatchSemaphore) {
    display.show("--> Writer arrived: \(name)")
    roomEmpty.wait()
    display.show("Critical Writer: \(name)")
    roomEmpty.signal()
    display.show("<-- Writer left: \(name)")
  }
}
