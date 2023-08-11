

import UIKit

class BeginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggIn(){
            guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {return}
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {return}
        print("hi")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func isLoggIn() ->Bool{
        return UserDefaults.standard.bool(forKey: "IsLoggedIn")
        
    }
}




