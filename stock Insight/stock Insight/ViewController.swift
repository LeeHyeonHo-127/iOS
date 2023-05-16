//
//  ViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchLoginButton(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {return}
        print("hi")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

