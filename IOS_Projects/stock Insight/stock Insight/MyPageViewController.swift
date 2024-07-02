//
//  MyPageViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit

class MyPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func modifyUserInfoButtonTapped(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false

    }
    
    
    
    @IBAction func logOutButtonTapped(_ sender: Any) {

        print("로그아웃 버튼 눌림")
        
        // 로그인 화면으로 이동합니다.
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func logOut(email: String, password: String) {
        let urlString = "https://watch.ngrok.app/logout"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }


        // URLRequest 생성
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        
        
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
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
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

    
}
