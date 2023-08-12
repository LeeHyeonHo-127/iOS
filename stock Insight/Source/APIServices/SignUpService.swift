import Foundation
import Alamofire

struct SignUpService{
    static let shared = SignUpService()
    
    //회원가입
    func singUp(email: String,
                password: String,
                name: String,
                completion: @escaping (NetworkResult<Any>) -> (Void) ) {
        
        let url = APIConstants.signUpURL
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "user_id" : email,
            "pw" : password,
            "name" : name
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: URLEncoding.default,
                                     headers: header)
        dataRequest.responseData(completionHandler: {(response) in
            switch response.result{
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                completion(doSignUp(status: statusCode, data: data))
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        })
    }
    
    //회원가입 여부 확인
    private func doSignUp(status: Int, data: Data) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<AuthData>.self, from: data) else {
            return .pathErr
        }
        
        switch status {
        case 201:
            // 회원가입 성공
            return .success(decodedData.data)
        case 400:
            // 중복된 이메일
            return .requestErr(decodedData.message)
        case 500:
            // 서버 내부 에러
            return .serverErr
        default:
            return .networkFail
        }
    }
}
