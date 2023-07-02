//
//  ViewController.swift
//  ATracker
//
//  Created by 이현호 on 2023/04/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentAssignment: UILabel!
    @IBOutlet var tableVIew: UITableView!
    
    var tasks: [Task] = [Task]()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableVIew.dataSource = self
        self.tableVIew.delegate = self
        makeHeaderView()
        addIndicatorVIew()

    }
    @objc func refresh(_ sender: AnyObject) {
        self.tableVIew.reloadData()
        self.refreshControl.endRefreshing()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addAssignmentViewController = segue.destination as? AddAssignmentViewController{
            addAssignmentViewController.delegate = self
        }
    }
    
    func makeHeaderView(){
        let headerView = UILabel(frame: CGRect(x: 0, y: 0, width: tableVIew.window?.layer.borderWidth ?? 30, height: 30))
        headerView.text = "Task List를 보여줍니다."
        headerView.textAlignment = .center
        self.tableVIew.tableHeaderView = headerView
    }
    
    func addIndicatorVIew(){
        tableVIew.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
}

extension ViewController: AddAssignmentViewDelegate{
    func selectedAssignment(task:String){
        let task = Task(title: task, done: false)
        self.tasks.append(task)
        self.tableVIew.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        if cell.textLabel?.text == nil{
            cell.textLabel?.text = "text 가 없습니다."
        }
            
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1")
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailTaskViewController") as? DetailTaskViewController else{return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
