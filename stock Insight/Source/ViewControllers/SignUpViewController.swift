import UIKit
import Foundation

class SignUpViewController: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rePasswordTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        userNameTextField.delegate = self
        self.signUpButton.isEnabled = false
        self.passwordTextField.isSecureTextEntry = true
        self.rePasswordTextField.isSecureTextEntry = true
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let rePassword = rePasswordTextField.text ?? ""
        let userName = userNameTextField.text ?? ""
        
        if password == rePassword{
//            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {return}
//            self.navigationController?.pushViewController(viewController, animated: true)
            self.signUp(email: email, password: password, userName: userName)
        }else{
            self.showAlert(title: "비밀번호가 일치하지 않습니다.")
        }
    }
    
    func signUp(email: String, password: String, userName: String){
//        let urlString = "http://172.17.104.130:8080/member/save"
        let urlString = "https://watch.ngrok.app/register"
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        
//        //파라미터 설정 JSON
//        let parameter: [String: Any] = [
//            "memberEmail" : email,
//            "memberPassword" : password,
//            "memberName" : userName
//        ]
        
        //파라미터 설정 JSON
        let parameter: [String: Any] = [
            "user_id" : email,
            "pw" : password,
            "name" : userName
        ]
        
        
        
        //URLRequest 설정
        var request = URLRequest(url:url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter) else {
                    showAlert(title: "파라미터를 변환하는데 실패했습니다.")
                    return
                }
//        if let httpBody = parameter.data(using: .utf8) {
//                    request.httpBody = httpBody
//                } else {
//                    showAlert(title: "파라미터를 변환하는데 실패했습니다.")
//                    return
//        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request){ [weak self](data,response, error) in
            guard let self = self else {return}
            if let error = error{
                let code = (error as NSError).code
                switch code{
                case 17007: //이미 가입한 계정일 때
                    DispatchQueue.main.async {
                        self.showAlert(title: "이미 가입한 계정입니다")
                    }
                    return
                default:
                    DispatchQueue.main.async {
                        self.showAlert(title: "회원가입 에러", message: "\(error.localizedDescription)")
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {return}
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }else{
                        self.showAlert(title: "회원가입 실패 \(httpResponse.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
    func showAlert(title: String, message: String? = nil) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
}





extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //return 키가 눌렸을 때 동작
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {//사용자가 텍스트 필드의 편집을 완료하고 텍스트 필드가 편집 모드에서 벗어났을 때 호출
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        let isRepasswordEmpty = rePasswordTextField.text == ""
        let isUserNameEmpty = userNameTextField.text == ""
        
        signUpButton.isEnabled = !isEmailEmpty && !isPasswordEmpty && !isRepasswordEmpty && !isUserNameEmpty
    }
}
