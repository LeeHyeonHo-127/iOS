//
//  ViewController.swift
//  UserDefaultsTest
//
//  Created by 이현호 on 2023/10/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.USERDEFAULTSTEST_set()
        self.USERDEFAULTSTEST_get()
    }

    //UserDefaults Test
    func USERDEFAULTSTEST_set(){
        if let data = try? JSONEncoder().encode("1"){
            UserDefaults.standard.set(data, forKey: "data")
        }
    }

    //UserDefaults Test
    func USERDEFAULTSTEST_get(){
        if let data = UserDefaults.standard.data(forKey: "data"){
            print("Userdefaults.standard.data(forKey: \"1\") = \(data)")
            let decodedData = try? JSONDecoder().decode(String.self, from: data)
            print("===============================")
            print("USERDEFAULTSTEST_get ---> \(decodedData)")
        }
        print("haha")
    }
}

