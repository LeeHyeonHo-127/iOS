//
//  ViewController.swift
//  delegatePractice
//
//  Created by 이현호 on 2022/12/29.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        //textField의 위임자 = ViewController
        //textField에 이벤트가 발생하면 프로토콜에 따라 ViewController가
        //textField에 응답을 준다.
    }
    @IBOutlet weak var enteredLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
//    @IBAction func buttoneClicked(_ sender: Any) {
//        //enteredLabel.text = textField.text
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredLabel.text = textField.text
        return true
    }
    //textFieldShouldReturn()은 UITextFieldDelegate안에 정의되어 있는 함수.
    //return(엔터) 입력이 들어올 때의 동작1.
}

