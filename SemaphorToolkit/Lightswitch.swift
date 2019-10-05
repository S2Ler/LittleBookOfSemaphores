import Foundation

public class Lightswitch {
  private var counter: Int = 0
  private let mutex = DispatchSemaphore(value: 1)

  public init() {

  }

  public func lock(_ semaphore: DispatchSemaphore) {
    mutex.wait()
    counter += 1
    if counter == 1 {
      semaphore.wait()
    }
    mutex.signal()
  }

  public func unlock(_ semaphore: DispatchSemaphore) {
    mutex.wait()
    counter -= 1
    if counter == 0 {
      semaphore.signal()
    }
    mutex.signal()
  }
}
