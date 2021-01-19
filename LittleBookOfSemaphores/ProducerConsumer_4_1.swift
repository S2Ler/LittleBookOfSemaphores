import Foundation
import SemaphorToolkit

struct Event: CustomStringConvertible {
  let id: Int
  func process(display: Display) {
    display.show("Event: process #\(id)")
  }

  var description: String {
    "Event#\(id)"
  }
}

final class Buffer {
  private let mutex: Sem = .init(value: 1)
  private var events: [Event] = []
  private var eventAvailable: Sem = Sem(value: 0)

  func add(_ event: Event, display: Display) {
    display.show("Add\(event): arrived")
    mutex.wait()
    display.show("Add\(event): waiting for lock")
    events.append(event)
    display.show("Add\(event): added and signaling")
    eventAvailable.signal()
    display.show("Add\(event): signaled")
    mutex.signal()
    display.show("Add\(event): unlocked")
  }

  func get(display: Display) -> Event {
    display.show("GetEvent: arrived, waiting for event")
    eventAvailable.wait()
    display.show("GetEvent: event available")
    mutex.wait()
    display.show("GetEvent: next event available")
    let event = events.removeFirst()
    display.show("GetEvent: poped event \(event)")
    mutex.signal()
    display.show("GetEvent: unlocked return \(event)")
    return event
  }
}

final class ProducerConsumerTask_4_1: Task {
  private var currentEventIdMutex: Sem = .init(value: 1)
  private var currentEventId: Int = 0
  private let buffer: Buffer = .init()
  let name: String = "Produce Consumer 4.1"

  func perform(display: Display) {
    DispatchQueue.global().async {
      DispatchQueue.concurrentPerform(iterations: 3) { (id) in
        self.sendProducer(display: display)
      }
    }
    DispatchQueue.global().async {
      DispatchQueue.concurrentPerform(iterations: 3) { (id) in
        self.sendConsumer(display: display)
      }
    }
  }

  private func sendProducer(display: Display) {
    display.show("Sending Producer")
    let event = waitForEvent(display: display)
    buffer.add(event, display: display)
  }

  private func sendConsumer(display: Display) {
    display.show("Sending Consumer")
    let event = buffer.get(display: display)
    event.process(display: display)
  }

  private func waitForEvent(display: Display) -> Event {
    display.show("Waiting for event")
    currentEventIdMutex.wait()
    currentEventId += 1
    let event = Event(id: currentEventId)
    currentEventIdMutex.signal()
    display.show("Produced new event")
    return event
  }
}
