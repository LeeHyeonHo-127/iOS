//
//  CodePush.swift
//  ScreenTransport
//
//  Created by 이현호 on 2022/12/23.
//

import UIKit

class CodePush: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name:String?


    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name{
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
        
        print("CodePush의 뷰가 로드 되었다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("CodePush의 뷰가 나타날 것이다.")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("CodePush의 뷰가 나타났다")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("CodePush의 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("CodePush의 뷰가 사라졌다..")
    }
    

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
