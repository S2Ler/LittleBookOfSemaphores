//
//  ExecutionViewController.swift
//  LittleBookOfSemaphores
//
//  Created by Alexander Belyavskiy on 11/30/16.
//  Copyright © 2016 Alexander Belyavskiy. All rights reserved.
//

import Foundation
import UIKit

final class ExecutionViewController: UIViewController {
  @IBOutlet var textView: UITextView!
  var task: Task!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textView.text = "About to execute task with name: \(task.name)\n\n"
    execute(task)
  }

  private func execute(_ task: Task) {
    UIApplication.shared.beginIgnoringInteractionEvents()
    task.perform(display: textView, completionQueue: .main) {
      UIApplication.shared.endIgnoringInteractionEvents()
    }
  }
}
