import Foundation
import SemaphorToolkit

// 3.3 
final class RendezvousTask: Task {
  var name: String { return "Rendezvous" }
  
  func perform(display: Display) {
    let b1Done = Sem(value: 0)
    let a1Done = Sem(value: 0)

    DispatchQueue.global().async {
        display.show("Statement a1")
        a1Done.signal()
        b1Done.wait()
        display.show("Statement a2")
    }

    DispatchQueue.global().async {
        display.show("Statement b1")
        b1Done.signal()
        a1Done.wait()
        display.show("Statement b2")
    }
  }
}
