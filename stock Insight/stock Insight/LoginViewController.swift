//
//  LoginViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pushLoginButton(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "bookMarkListView") as? BookMarkListViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func login(email: String, password: String) {
        let urlString = "http://your-backend-server.com/login"
        guard let url = URL(string: urlString) else {
            // URL 형식이 올바르지 않은 경우 처리
            return
        }
        
        // 요청에 필요한 파라미터 설정
        let parameters: [String: Any] = [
            "userId": email,
            "password": password
        ]
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        // URLSession을 사용하여 요청 보내기
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // 요청 실패 처리
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // 로그인 성공 처리
                    if let data = data {
                        // 응답 데이터 처리
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            if let responseDict = json as? [String: Any] {
                                let status = responseDict["status"] as? Int
                                let message = responseDict["message"] as? String
                                let userToken = responseDict["userToken"] as? String
                                // 로그인 성공 후 처리할 내용을 여기에 작성
                            }
                        } catch {
                            // JSON 데이터 파싱 실패 처리
                            print("JSON parsing error: \(error)")
                        }
                    }
                } else {
                    // 로그인 실패 처리
                    print("Login failed with status code: \(httpResponse.statusCode)")
                }
            }
        }
        
        // 요청 보내기
        task.resume()
    }

}
