import Foundation
import Alamofire

struct GetIndexService{
    static let shared = GetIndexService()
    
    //주요 지수 가져오기
    func getIndex(completion: @escaping (NetworkResult<Any>) -> (Void) ) {
        
        
        let url = APIConstants.getIndexInfo
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [:]
        
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
                completion(judgeGetIndex(status: statusCode, data: data))
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        })
    }
    
    //주요 지수 가져오기 여부 확인
    private func judgeGetIndex(status: Int, data: Data) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(IndexURLStrings.self, from: data) else {
            return .pathErr
        }
        
        
        
        switch status {
        case 200:
            // 성공
            var indexURLs = IndexURLs(KOSPI: URL(string: decodedData.KOSPI)!,
                                      KOSDAQ: URL(string: decodedData.KOSDAQ)!,
                                      KOSPI200: URL(string: decodedData.KOSPI200)!)
            return .success(indexURLs)
            
        case 408:
            // API 문제로 요청 시간초과
            var overTimeMessage = "API 문제로 요청 시간초과"
            return .requestErr(overTimeMessage)
        case 400:
            // 잘못된 파라미터
            return .wrongParameter
        default:
            return .networkFail
        }
    }
}
