//
//  AddAssignmentViewController.swift
//  ATracker
//
//  Created by 이현호 on 2023/04/13.
//

import UIKit

protocol AddAssignmentViewDelegate: AnyObject{
    func selectedAssignment(task:String)
}

class AddAssignmentViewController: UIViewController {

    @IBOutlet var assignmentTextField: UITextField!
    var currentAssignment: String = "바뀌기전"
    var delegate:AddAssignmentViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let assignmentText = self.assignmentTextField.text else {return}
        self.currentAssignment = assignmentText
        print(currentAssignment)
        delegate?.selectedAssignment(task: currentAssignment)
        dismiss(animated: true)
    }
    
    
}
