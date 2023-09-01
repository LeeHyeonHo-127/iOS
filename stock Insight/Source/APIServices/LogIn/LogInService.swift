import Foundation
import Alamofire

struct LogInService{
    static let shared = LogInService()
    
    func logIn(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void){
        let url = APIConstants.logInURL
        print("======LogInService.LogIn In=========")
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameter: Parameters = [
            "user_id": email,
            "pw": password
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: parameter,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData(completionHandler: {response in
            switch response.result{
            case .success:
                print("======LogiIn Success=========")
                guard let status = response.response?.statusCode else {return}
                guard let data = response.value else {return}
                completion(doLogIn(status: status, data: data, url: URL(string: url)!))
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        })
    }
    
    
    func doLogIn(status: Int, data: Data, url: URL) -> NetworkResult<Any>{
        print("======doLogIn In=========")
        print("======Decoding 시도=========")
        let decoder = JSONDecoder()
        print(type(of: data))
        guard let decodedData = try? decoder.decode(User.self, from: data) else {return .pathErr}
        print("======Decoding 성공=========")
        
        
        switch status {
        case 200: // 로그인 성공
            //토큰 저장
            print("=====Status200 성공!=========")
            if let cookies = HTTPCookieStorage.shared.cookies(for: url) {
                for cookie in cookies {
                    if cookie.name == "access_token" {
                        print("Received access token:", cookie.value)
                        UserDefaults.standard.set(cookie.value, forKey: cookie.name)
                    }
                    else if cookie.name == "refresh_token"{
                        print("Received refresh token:", cookie.value)
                        UserDefaults.standard.set(cookie.value, forKey: cookie.name)
                    }
                }
            }
            return .success(decodedData)
        case 404:
            print("=====Status404 실패=========")
            // 존재하지 않는 회원
            print("400")
            return .requestErr(decodedData)
        case 400:
            // 에러
            print("500")
            return .serverErr
        default:
            print("default")
            return .networkFail
            
        }
    }
}



