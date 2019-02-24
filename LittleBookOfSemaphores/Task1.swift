//
//  Task1.swift
//  LittleBookOfSemaphores
//
//  Created by Alexander Belyavskiy on 11/30/16.
//  Copyright © 2016 Alexander Belyavskiy. All rights reserved.
//

import Foundation

final class Task1: Task {
  var name: String { return "Task1" }
  
  func perform(display: Display, completionQueue: DispatchQueue, completion: @escaping () -> Void) {
    display.show("Starting")
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2), execute: {
      for i in 0..<10 {
        Thread.sleep(forTimeInterval: 0.1)
        display.show("tick: \(i)")
      }

      completionQueue.async {
        display.show("Finished")
        completion()
      }
    })
  }
}
