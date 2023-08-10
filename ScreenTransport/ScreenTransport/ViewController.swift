//
//  ViewController.swift
//  ScreenTransport
//
//  Created by 이현호 on 2022/12/23.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController의 뷰가 로드 되었다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController의 뷰가 나타날 것이다.")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController의 뷰가 나타났다")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController의 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController의 뷰가 사라졌다..")
    }

    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else {return}
        viewController.name = "HelloWorld"
        viewController.delegate = self //viewController의 delegate변수에 들어있는 SendDataDelegate protocol을 위임
        
        self.present(viewController, animated: true, completion: nil);
        
    }
    
    
    @IBAction func tapCodePush(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "codePushViewController") as? CodePush else { return } //다운캐스팅을 하면 각 클래스의 프로퍼티에 접근할 수 있다
        //viewController.name = "HelloWorld"

        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePushViewController{
            viewController.name = "HelloWorldMF"
        }
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

