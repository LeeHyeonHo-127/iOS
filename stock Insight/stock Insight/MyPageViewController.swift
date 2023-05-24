//
//  MyPageViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit

class MyPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func modifyUserInfoButtonTapped(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false

    }
    
    
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
