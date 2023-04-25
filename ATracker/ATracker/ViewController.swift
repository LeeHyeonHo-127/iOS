//
//  ViewController.swift
//  ATracker
//
//  Created by 이현호 on 2023/04/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentAssignment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addAssignmentViewController = segue.destination as? AddAssignmentViewController{
            print("!!!")
            addAssignmentViewController.delegate = self
        }
    }
    
}

extension ViewController: AddAssignmentViewDelegate{
    func selectedAssignment(assignment:String){
        print(assignment)
        self.currentAssignment.text = assignment
    }
}
