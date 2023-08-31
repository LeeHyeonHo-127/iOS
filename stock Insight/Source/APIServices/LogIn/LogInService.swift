import Foundation
import Alamofire

struct LogInService{
    static let shared = LogInService()
    
    func logIn(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void){
        let url = APIConstants.logInURL
        
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
                guard let status = response.response?.statusCode else {return}
                guard let data = response.value else {return}
                completion(doLogIn(status: status, data: data))
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        })
    }
    
    
    func doLogIn(status: Int, data: Data) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<User>.self, from: data) else {return .pathErr}
        
        
        switch status {
        case 200:
            // 로그인 성공
            return .success(decodedData.data)
        case 404:
            // 존재하지 않는 회원
            print("400")
            return .requestErr(decodedData.message)
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
