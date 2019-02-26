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
    DispatchQueue.global().async {
        task.perform(display: self.textView)
    }
  }
}
