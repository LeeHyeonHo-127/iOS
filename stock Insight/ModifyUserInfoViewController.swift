import UIKit

class ModifyUserInfoViewController: UIViewController {
    
    
    
    @IBOutlet var modifyUserInfoButton: UIButton!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var oldPwTextField: UITextField!
    @IBOutlet var newPwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.delegate = self
        oldPwTextField.delegate = self
        newPwTextField.delegate = self
        self.modifyUserInfoButton.isEnabled = false
        self.oldPwTextField.isSecureTextEntry = true
        self.newPwTextField.isSecureTextEntry = true

    }
    
    @IBAction func modifyUserInfoButtonTapped(_ sender: Any) {
        let user_id = userIdTextField.text ?? ""
        let old_pw = oldPwTextField.text ?? ""
        let new_pw = newPwTextField.text ?? ""
        self.dismiss(animated: true, completion: nil)
        self.modifyPassword(user_id:user_id, old_pw: old_pw, new_pw: new_pw )
    }
    
    
    //비밀번호 수정///
    func modifyPassword(user_id:String, old_pw:String, new_pw:String){
        let urlString = "https://watch.ngrok.app/logineditProc"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }
        let parameter: [String: Any] = [
            "user_id": user_id,
            "old_pw": old_pw,
            "new_pw": new_pw
        ]
        // URLRequest 생성
        var request = URLRequest(url: url)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter) else {
            DispatchQueue.main.async {
                self.showAlert(title: "파라미터를 변환하는데 실패했습니다.")
            }
            return
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
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
                        self.showAlert(title: "비밀번소 수정 에러", message: "\(error.localizedDescription)")
                    }
                    return
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        self.showAlert(title: "비밀번호 수정 완료")
                        self.dismiss(animated: true, completion: nil)
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
        let userIdEmpty = userIdTextField.text == ""
        let oldPwEmpty = oldPwTextField.text == ""
        let newPwEmpty = newPwTextField.text == ""
        
        modifyUserInfoButton.isEnabled = !userIdEmpty && !oldPwEmpty && !newPwEmpty
    }
}
