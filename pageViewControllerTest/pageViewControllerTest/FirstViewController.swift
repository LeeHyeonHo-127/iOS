//
//  FirstViewController.swift
//  pageViewControllerTest
//
//  Created by 이현호 on 2023/08/17.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var helloWorldLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.helloWorldLabel.isHidden = true
    }
    

    @IBAction func tappedHelloButton(_ sender: Any) {
        self.helloWorldLabel.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
