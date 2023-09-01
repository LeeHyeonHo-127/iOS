import Foundation
import Alamofire

struct LogOutService{
    static let shared = LogOutService()
    
    func logOut(completion: @escaping (NetworkResult<Any>) -> Void){
        let url = APIConstants.logOutURL
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
 
        let dataRequest = AF.request(url,
                                     method: .get,
                                     headers: header)
        dataRequest.responseData(completionHandler: {response in
            switch response.result{
            case .success:
                guard let status = response.response?.statusCode else {return}
                guard let data = response.value else {return}
                completion(doLogOut(status: status, data: data))
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        })
    }
    
    
    func doLogOut(status: Int, data: Data) -> NetworkResult<Any>{
        let msg1 = "성공"
        let msg2 = "실패"
        
        switch status {
        case 200:
            // 로그인 성공
            return .success(msg1)
        case 404:
            // 존재하지 않는 회원
            print("400")
            return .requestErr(msg2)
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
