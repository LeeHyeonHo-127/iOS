import UIKit

class ModifyUserInfoViewController: UIViewController {
    
    
    @IBOutlet var modifyUserInfoButton: UIButton!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var rePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        userNameTextField.delegate = self
        self.modifyUserInfoButton.isEnabled = false
        self.passwordTextField.isSecureTextEntry = true
    }
    
    
    @IBAction func modifyUserInfoButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let rePassword = rePasswordTextField.text ?? ""
        let userName = userNameTextField.text ?? ""
        
        if password == rePassword{
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {return}
            self.navigationController?.pushViewController(viewController, animated: true)
            self.modifyUserInfo(email: email, password: password, userName: userName)
        }else{
            self.showAlert(title: "비밀번호가 일치하지 않습니다.")
        }
    }
    
    func modifyUserInfo(email: String, password: String, userName: String){
        let urlString = "http://192.168.200.102:8080"
        guard let url = URL(string: urlString) else {
            return
        }
        
        
        
        // 요청에 필요한 파라미터 설정
        let parameter: [String: Any] = [
            "userID" : email,
            "password" : password,
            "username" : userName
        ]
        
        //URLRequest 설정
        var request = URLRequest(url:url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter) else {
                    showAlert(title: "파라미터를 변환하는데 실패했습니다.")
                    return
                }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request){ [weak self](data,response, error) in
            guard let self = self else {return}
            if let error = error{
                let code = (error as NSError).code
                switch code{
                case 17007:
                    DispatchQueue.main.async {
                        self.showAlert(title: "")
                    }
                    return
                default:
                    DispatchQueue.main.async {
                        self.showAlert(title: "회원정보 수정 에러", message: "\(error.localizedDescription)")
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {return}
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }else{
                        self.showAlert(title: "회원정보 수정 실패")
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
extension ModifyUserInfoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //return 키가 눌렸을 때 동작
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {//사용자가 텍스트 필드의 편집을 완료하고 텍스트 필드가 편집 모드에서 벗어났을 때 호출
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        let isRepasswordEmpty = rePasswordTextField.text == ""
        let isUserNameEmpty = userNameTextField.text == ""
        
        modifyUserInfoButton.isEnabled = !isEmailEmpty && !isPasswordEmpty && !isRepasswordEmpty && !isUserNameEmpty
    }
}
