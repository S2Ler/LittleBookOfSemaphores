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
  func perform(display: Display, completionQueue: DispatchQueue, completion: @escaping () -> Void)
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
  Task1.self,
]
