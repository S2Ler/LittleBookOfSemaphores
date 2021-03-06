//
//  Task.swift
//  LittleBookOfSemaphores
//
//  Created by Alexander Belyavskiy on 11/30/16.
//  Copyright © 2016 Alexander Belyavskiy. All rights reserved.
//

import Foundation

protocol Task {
  init()
  var name: String { get }
  func perform(display: Display)
}

protocol Display {
  func show(_ string: String)
}

final class ConsoleDisplay: Display {
  func show(_ string: String) {
    print(string)
  }
}

internal let taskTypes: [Task.Type] = [
  RendezvousTask.self,
  TurnstileTask.self,
  BarrierTask.self,
  ReadersWriters.self,
  Queue_3_8_Task.self,
  Queue_3_8_2_Task.self,
  ProducerConsumerTask_4_1.self,
]
