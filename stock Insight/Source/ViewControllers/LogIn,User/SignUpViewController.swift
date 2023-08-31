import UIKit
import Foundation

class SignUpViewController: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rePasswordTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    
    //viewDidLoad
    override func viewDidLoad() {
        self.configureTexFieldAndButton()
    }
    

    //MARK: 설정 함수
    
    //Attach ActivityIndicator
    private func attachActivityIndicator() {
        self.view.addSubview(self.activityIndicator)
    }
    
    //Dettach ActivityIndicator
    private func detachActivityIndicator() {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
        }
        self.activityIndicator.removeFromSuperview()
    }
    
    //configure TextField and Button 함수
    func configureTexFieldAndButton(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        userNameTextField.delegate = self
        
        self.signUpButton.isEnabled = false
        self.passwordTextField.isSecureTextEntry = true
        self.rePasswordTextField.isSecureTextEntry = true
    }
    
    
    //MARK: 회원가입 버튼

    //회원가입 버튼
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let rePassword = rePasswordTextField.text ?? ""
        let userName = userNameTextField.text ?? ""
        
        if password == rePassword{
            self.signUpWithAPI(email: email, password: password, userName: userName)

        }else{
            self.showAlert(title: "비밀번호가 일치하지 않습니다.")
        }
    }
    
    
    //MARK: 회원가입 함수
    
    func signUpWithAPI(email: String, password: String, userName: String){
        self.attachActivityIndicator()
        
        SignUpService.shared.singUp(email: email, password: password, name: userName, completion: {(networkResult) -> Void in
            self.detachActivityIndicator()
            
            switch networkResult{
            case .success(let data):
                if let signUpData = data as? User{
                    print("회원가입 성공")
                    // 회원가입 성공
//                    APIConstants.userId = signUpData.user.id
//                    UserDefaults.standard.setValue(signUpData.token, forKey: "token")
//                    UserDefaults.standard.setValue(signUpData.user.id, forKey: "userId")
//                    UserDefaults.standard.setValue("email", forKey: "loginType")
//                    UserDefaults.standard.setValue(false, forKey: "didLogin")
                    
                    guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {return}
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                    
                    guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {return}
                    self.navigationController?.pushViewController(viewController, animated: true)
                }else{
                    print("회원가입 실패")
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr:
                print("pathErr in postSignUpWithAPI")
            case .serverErr:
                print("serverErr in postSignUpWithAPI")
            case .networkFail:
                print("networkFail in postSignUpWithAPI")
            default:
                print("networkFail in signUpWithAPI")
            }
        })
    }
    
    
    //과거 버전
    func signUp_urlSessionVer(email: String, password: String, userName: String){
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
    
    
    //MARK: 기타 함수
    func showAlert(title: String, message: String? = nil) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
}




extension SignUpViewController: UITextFieldDelegate{
    //return 키가 눌리면 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //return 키가 눌렸을 때 동작
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {//사용자가 텍스트 필드의 편집을 완료하고 텍스트 필드가 편집 모드에서 벗어났을 때 호출
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        let isRepasswordEmpty = rePasswordTextField.text == ""
        let isUserNameEmpty = userNameTextField.text == ""
        
        self.signUpButton.isEnabled = !isEmailEmpty && !isPasswordEmpty && !isRepasswordEmpty && !isUserNameEmpty
    }
}
