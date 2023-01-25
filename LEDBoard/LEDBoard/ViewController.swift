//
//  ViewController.swift
//  LEDBoard
//
//  Created by 이현호 on 2022/12/27.
//

import UIKit

class ViewController: UIViewController,LEDBoardSettingDelegate {

    @IBOutlet var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentLabel.textColor = UIColor.purple;
        self.view.backgroundColor  = UIColor.black;
    }
    
    //prepare 메소드를 활용해 현재 값을 settingViewController로 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController{
            settingViewController.delegate = self //위임자를 self로 지정
            settingViewController.ledText = self.contentLabel.text
            settingViewController.textColor = self.contentLabel.textColor ?? .purple
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    //프로토콜의 메서드 구현
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contentLabel.text = text
        }
        self.contentLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }

}

