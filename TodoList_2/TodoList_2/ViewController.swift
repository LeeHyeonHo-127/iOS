//
//  ViewController.swift
//  TodoList_2
//
//  Created by 이현호 on 2023/01/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var doneButton: UIBarButtonItem!
    
    var tasks:[Task] = [Task](){
        didSet{
            self.saveTasks()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTasks()
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
    }
    
    
    @objc func doneButtonTap(){
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
        
    }

    @IBAction func editButton(_ sender: UIBarButtonItem) {
        guard !self.tasks.isEmpty else {return}
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert) //proferredStyle 이란?
        let resisterButton = UIAlertAction(title: "등록", style: .default, handler: {[weak self] _ in
            guard let textfield = alert.textFields?[0].text else {return}
            let task = Task(title: textfield, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(resisterButton)
        alert.addAction(cancelButton)
        alert.addTextField { textField in
            textField.placeholder = "할 일을 등록해 주세요"
        }
        
        self.present(alert, animated: true)
    }
    
    func saveTasks(){
        let data = self.tasks.map{
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "tasks")
    }
    
    func loadTasks(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String : Any]] else {return}
        self.tasks = data.compactMap{
            guard let title = $0["title"] as? String else {return nil}
            guard let done = $0["done"] as? Bool else {return nil}
            return Task(title: title, done: done)
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        if task.done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty{
            self.doneButtonTap()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        var task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
