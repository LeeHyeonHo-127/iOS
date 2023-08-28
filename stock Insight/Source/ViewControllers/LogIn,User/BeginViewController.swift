

import UIKit



class BeginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        if isLoggIn(){
//            guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {return}
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
    }
    
    //MARK: 버튼 함수

    //로그인 화면으로 이동
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //회원가입 화면으로 이동
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //로그인 되었는지 확인
    func isLoggIn() ->Bool{
        return UserDefaults.standard.bool(forKey: "IsLoggedIn")
    }
}




class BeginNavigationController: UINavigationController{
    
}
