//
//  EnterEmailViewController.swift
//  LogIn_fc
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passworldTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        nextButton.layer.cornerRadius = 30
        
        emailTextField.delegate = self
        passworldTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passworldTextField.text ?? ""
        
        //신규 사용자 생성
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else {return}
            
            if let error = error{
                let code = (error as NSError).code
                switch code{
                case 17007: //이미 가입한 계정일 때
                    loginUser(withEmail: email, password: password)
                default:
                    self.errorLabel.text = error.localizedDescription
                }
            }else{
                showMainViewController()
            }
        }
    }
    
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){[weak self] _, error in
            guard let self = self else {return}
            if let error = error{
                self.errorLabel.text = error.localizedDescription
            }else{
                showMainViewController()
            }
        }
    }
}


extension EnterEmailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //return 키가 눌렸을 때 동작
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {//사용자가 텍스트 필드의 편집을 완료하고 텍스트 필드가 편집 모드에서 벗어났을 때 호출
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passworldTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
