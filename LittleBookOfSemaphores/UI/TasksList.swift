import UIKit

class TasksList: UITableViewController {
  private lazy var tasks: [Task] = {
    taskTypes.map { $0.init() }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellID = "TaskCell"
    let cell: UITableViewCell
    if let oldCell = tableView.dequeueReusableCell(withIdentifier: cellID) {
      cell = oldCell
    } else {
      cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
    }

    let task = getTask(at: indexPath)
    cell.textLabel?.text = task.name
    return cell
  }

  private func getTask(at indexPath: IndexPath) -> Task {
    return tasks[indexPath.row]
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let task = getTask(at: indexPath)
    performSegue(withIdentifier: "execTask", sender: task)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let task = sender as! Task
    let executor = segue.destination as! ExecutionViewController
    executor.task = task
  }
}

extension UITextView: Display {
  func show(_ string: String) {
    if Thread.isMainThread {
      var newText = self.text ?? ""
      newText.append("\(string)\n")
      self.text = newText
    } else {
      DispatchQueue.main.sync {
        self.show(string)
      }
    }
  }
}
