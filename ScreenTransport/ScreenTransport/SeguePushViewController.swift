//
//  SeguePushViewController.swift
//  ScreenTransport
//
//  Created by 이현호 on 2022/12/23.
//

import UIKit

class SeguePushViewController: UIViewController {
   
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = name;
        self.nameLabel.sizeToFit()
        print("SeguePushViewController의 뷰가 로드 되었다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SeguePushViewController의 뷰가 나타날 것이다.")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SeguePushViewController의 뷰가 나타났다")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SeguePushViewController의 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SeguePushViewController의 뷰가 사라졌다..")
    }
}
