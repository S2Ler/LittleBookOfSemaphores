import Foundation

public class Lightswitch {
  private var counter: Int = 0
  private let mutex = Sem(value: 1)

  public init() {

  }

  public func lock(_ semaphore: Sem) {
    mutex.wait()
    counter += 1
    if counter == 1 {
      semaphore.wait()
    }
    mutex.signal()
  }

  public func unlock(_ semaphore: Sem) {
    mutex.wait()
    counter -= 1
    if counter == 0 {
      semaphore.signal()
    }
    mutex.signal()
  }
}
