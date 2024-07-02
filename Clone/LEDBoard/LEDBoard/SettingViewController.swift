//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by 이현호 on 2022/12/29.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject{
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    

    @IBOutlet var textField: UITextField!
    @IBOutlet var blueButton : UIButton!
    @IBOutlet var whiteButton: UIButton!
    @IBOutlet var purpleButton: UIButton!
    @IBOutlet var blackButton: UIButton!
    @IBOutlet var orangeButton: UIButton!
    @IBOutlet var yellowButton: UIButton!
    
    var textColor: UIColor = .purple
    var backgroundColor : UIColor = .black
    var ledText: String?
    
    weak var delegate: LEDBoardSettingDelegate?
    
    
    //지정한 값으로 세팅
    private func configureView(){
        if let ledText = self.ledText{
            self.textField.text = ledText
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackgroundColorButton(color: self.backgroundColor)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    //글자 색 버튼
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == self.blueButton{
            self.changeTextColor(color: .blue)
            self.textColor = .blue
        }
        else if sender == self.whiteButton{
            self.changeTextColor(color: .white)
            self.textColor = .white
        }else{
            self.changeTextColor(color: .purple)
            self.textColor = .purple
        }
    }
    
   //배경 색 버튼
    @IBAction func tapBackgroundColor(_ sender: UIButton) {
        if sender == self.blackButton{
            self.changeBackgroundColorButton(color: .black)
            self.backgroundColor = .black
        }else if(sender == self.orangeButton){
            self.changeBackgroundColorButton(color: .orange)
            self.backgroundColor = .orange
        }else{
            self.changeBackgroundColorButton(color: .yellow)
            self.backgroundColor = .yellow
        }
    }
    
    //저장 버튼  프로토콜 타입의 변수 delegate에 값 입력.
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.changedSetting(
            text: self.textField.text,
            textColor: self.textColor,
            backgroundColor: self.backgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    // 현재 글자 색을 보여주는 기능
    private func changeTextColor(color: UIColor){
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.whiteButton.alpha = color == UIColor.white ? 1 : 0.2
    }
    
    // 현재 베경 색을 보여주는 기능
    private func changeBackgroundColorButton(color : UIColor){
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
    }
}
