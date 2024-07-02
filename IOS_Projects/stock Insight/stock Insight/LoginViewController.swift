import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.isSecureTextEntry = true
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? "1"
        let password = passwordTextField.text ?? "1"
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TapBarController") as? UITabBarController else {return}
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(viewController, animated: true)
//        self.login(email: email, password: password)
    }
    
    func login(email: String, password: String) {
        let urlString = "https://watch.ngrok.app/loginProc"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }
//        self.showAlert(title: "url 객체 변환 성공")
        
        // 요청에 필요한 파라미터 설정
//        let parameter: [String: Any] = [
//            "memberEmail": email,
//            "memberPassword": password
//        ]
        //node.js parameter
        
        let parameter: [String: Any] = [
            "user_id": email,
            "pw": password
        ]

        // URLRequest 생성
        var request = URLRequest(url: url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter) else {
            DispatchQueue.main.async {
                self.showAlert(title: "파라미터를 변환하는데 실패했습니다.")
                }
                return
        }
//        showAlert(title: "파라미터를 변환하는데 성공했습니다.")
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        // URLSession을 사용하여 요청 보내기
        let task = URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            guard let self = self else {return}
            
            if let error = error{
                let code = (error as NSError).code
                switch code{
                case 17007: //아이디 및 비밀버호가 다를 때
                    DispatchQueue.main.async {
                        self.showAlert(title: "아이디/비밀번호를 확인해 주세요")
                    }
                    return
                default:
                    DispatchQueue.main.async {
                        self.showAlert(title: "로그인 에러", message: "\(error.localizedDescription)")
                    }
                    return
                }
            }
            
            //httpResponse 응답 처리
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TapBarController") as? UITabBarController else {return}
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                   
//                    if let data = data {
//                        // 응답 데이터 처리
//                        do {
//                            let json = try JSONSerialization.jsonObject(with: data, options: [])
//                            if let responseDict = json as? [String: Any] {
//                                let status = responseDict["status"] as? Int
//                                let message = responseDict["message"] as? String
////                                guard let userToken = responseDict["userToken"] as? String else {return}
////                                self.saveToken(userToken)
//                                DispatchQueue.main.async {
//                                    guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {return}
//                                    self.navigationController?.pushViewController(viewController, animated: true)
//                                    }
//                            }
//                        } catch {
//                            DispatchQueue.main.async {
//                                self.showAlert(title: "파싱에러")
//                            }
//                        }
//                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "로그인에 실패했습니다")
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
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "UserToken")
        UserDefaults.standard.set(true, forKey: "I")
    }
    
}

