import Foundation
import Alamofire

struct ModifyPasswordService{
    static let shared = ModifyPasswordService()
    
    //회원가입
    func modifyPassword(email: String,
                oldPassword: String,
                newPassword: String,
                completion: @escaping (NetworkResult<Any>) -> (Void) ) {
        
        
        let url = APIConstants.signUpURL
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "user_id" : email,
            "old_ps" : oldPassword,
            "new_pw" : newPassword
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
        guard let decodedData = try? decoder.decode(User.self, from: data) else {
            return .pathErr
        }
        
        switch status {
        case 200:
            // 비밀번호 수정 완요
            return .success(decodedData)
        case 409:
            // 중복된 이메일
            return .requestErr(decodedData)
        case 400:
            // 잘못된 파라미터
            return .wrongParameter
        default:
            return .networkFail
        }
    }
}
