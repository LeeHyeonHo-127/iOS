//
//  ViewController.swift
//  Calculator
//
//  Created by 이현호 on 2023/01/03.
//

import UIKit

enum Operation{
    case Add
    case Subtract
    case Divide
    case Multiply
    case unowned
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    

    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation : Operation = .unowned
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        operationButton(operation: .Divide)
    }
    @IBAction func tapMultipleButton(_ sender: Any) {
        operationButton(operation: .Multiply)
    }
    @IBAction func tapSubtractButton(_ sender: Any) {
        operationButton(operation: .Subtract)
    }
    @IBAction func tapPlusButton(_ sender: Any) {
        operationButton(operation: .Add)
    }
    @IBAction func tapEqualButton(_ sender: Any) {
        operationButton(operation: self.currentOperation)
    }
    
    
    @IBAction func tapResetButton(_ sender: Any) {
        displayNumber = ""
        firstOperand = ""
        secondOperand = ""
        currentOperation = .unowned
        self.resultLabel!.text = "0"
    }
    
    @IBAction func putNumber(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else {return}
        if displayNumber.count < 9{
            self.displayNumber += numberValue
            self.resultLabel!.text = displayNumber
        }
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if displayNumber.count < 8 && !displayNumber.contains("."){
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.resultLabel.text = self.displayNumber
        }
    }
    
    
    func operationButton (operation: Operation){ // 계산 버튼이 눌림
        if self.currentOperation != .unowned{ // 원래 눌린 연산 버튼이 있을 때
            if !self.displayNumber.isEmpty{
                self.secondOperand = self.displayNumber
                guard let firstOperand = Double(self.firstOperand) else {return}
                guard let secondOperand = Double(self.secondOperand) else {return}
                
                switch self.currentOperation{
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                default:
                    break;
                }
                
                self.currentOperation = operation
                
                //정수일 떄 소수점 생략
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 { //truncatingRemainder() 는 Double,Float의 나머지를 구하는 함수ㅇ
                    self.result = "\(Int(result))"
                }
                
                self.displayNumber = self.result
                self.firstOperand = self.result
                self.secondOperand = ""
                self.resultLabel.text = displayNumber
                displayNumber = ""
            }else{
                self.currentOperation = operation
            }
        return;
        }else{ //원래 눌린 연산 버튼이 없을 때
            self.currentOperation = operation
            self.firstOperand = displayNumber
            self.displayNumber = ""
        }
    }
    
   
    
}

