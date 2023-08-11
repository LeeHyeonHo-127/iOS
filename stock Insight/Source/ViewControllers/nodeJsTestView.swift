
import UIKit
import Foundation

class nodeJsTestView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAlert(title: "즐겨찾기 테스트 실행")
        self.test()
    }
    
 
    
    //비밀번호 수정///
    func test1(){
        let urlString = "https://d526-39-118-146-240.ngrok-free.app/logineditProc"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }
        let parameter: [String: Any] = [
            "user_id": "sixthSignUp",
            "old_pw": "1",
            "new_pw": "2"
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
                        self.showAlert(title: "로그인 에러", message: "\(error.localizedDescription)")
                    }
                    return
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200{
                    DispatchQueue.main.async {
                        self.showAlert(title: "url 객체 변환 성공")
                    }
                }
                
            }
        }
        task.resume()
    }
    
//    즐겨찾기 파싱
    func test2() {
        let urlString = "https://fe3f-39-118-146-240.ngrok-free.app/logineditProc"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }

        let parameter: [String: Any] = [
            "title": "apple",
            "code": "1111"
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

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpBody = httpBody

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

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("1")
                    if let data = data {
                        print("2")
                        do {
                            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                                print(jsonArray)
                                   if let jsonArray = jsonArray {
                                       for jsonDict in jsonArray {
                                           let idx = jsonDict["idx"] as? Int
                                           let title = jsonDict["title"] as? String
                                           let code = jsonDict["code"] as? String

                                           DispatchQueue.main.async {
                                               self.showAlert(title: "\(idx)  \(title)  \(code)")
                                           }
                                           // 이후 원하는 작업 수행
                                           // idx, title, code 변수를 활용하여 필요한 처리를 진행할 수 있습니다.
                                       }
                                   }
                        }catch{
                            DispatchQueue.main.async {
                                self.showAlert(title: "즐겨찾기 파싱 실패")
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
    //findName
    func test3() {
        let urlString = "https://watch.ngrok.app/findname"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }

        let parameter: [String: Any] = [
            "user_id": "firstSignUp",
            "pw": "1"
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

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("1")
                    if let data = data {
                        print("2")
                        do {
                            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                                print("jsonArray = \(jsonArray)")
                                   if let jsonArray = jsonArray {
                                       for jsonDict in jsonArray {
                                           let idx = jsonDict["idx"] as? Int
                                           let title = jsonDict["title"] as? String
                                           let code = jsonDict["code"] as? String

                                           DispatchQueue.main.async {
                                               self.showAlert(title: "\(idx)  \(title)  \(code)")
                                           }
                                           // 이후 원하는 작업 수행
                                           // idx, title, code 변수를 활용하여 필요한 처리를 진행할 수 있습니다.
                                       }
                                   }
                        }catch{
                            DispatchQueue.main.async {
                                self.showAlert(title: "즐겨찾기 파싱 실패")
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    
    //회원 탄퇴
    func test() {
        let urlString = "https://watch.ngrok.app/logindeactivate"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.showAlert(title: "url 객체 변환 실패")
            }
            return
        }

        let parameter: [String: Any] = [
            "user_id": "testing",
            "pw": "12345678"
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

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("1")
                    if let data = data {
                        print("2")
                        do {
                            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                                print("jsonArray = \(jsonArray)")
                                   if let jsonArray = jsonArray {
                                       for jsonDict in jsonArray {
                                           let idx = jsonDict["idx"] as? Int
                                           let title = jsonDict["title"] as? String
                                           let code = jsonDict["code"] as? String

                                           DispatchQueue.main.async {
                                               self.showAlert(title: "\(idx)  \(title)  \(code)")
                                           }
                                           // 이후 원하는 작업 수행
                                           // idx, title, code 변수를 활용하여 필요한 처리를 진행할 수 있습니다.
                                       }
                                   }
                        }catch{
                            DispatchQueue.main.async {
                                self.showAlert(title: "즐겨찾기 파싱 실패")
                            }
                        }
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
    

