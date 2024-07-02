//
//  CodePresentViewController.swift
//  ScreenTransport
//
//  Created by 이현호 on 2022/12/23.
//

import UIKit

protocol SendDataDelegate: AnyObject{
    func sendData(name: String)
}


class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name:String?
    weak var delegate: SendDataDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
        print("CodePresentViewController 뷰가 로드 되었다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("CodePresentViewController의 뷰가 나타날 것이다.")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("CodePresentViewController의 뷰가 나타났다")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("CodePresentViewController의 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("CodePresentViewController의 뷰가 사라졌다..")
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "HELLOWORLD")
        presentingViewController?.dismiss(animated: true)
    }
    
    

}
