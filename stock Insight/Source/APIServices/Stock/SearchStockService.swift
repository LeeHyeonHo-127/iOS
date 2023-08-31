import Foundation
import Alamofire

struct SearchStockService{
    static let shared = SearchStockService()
    
    //종목 검색
    func searchStock(stockName: String,
                completion: @escaping (NetworkResult<Any>) -> (Void) ) {
        
        
        let url = APIConstants.searchStockInfo
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "stockName" : stockName
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
                completion(judgeSearchStock(status: statusCode, data: data))
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        })
    }
    
    //종목 검색 여부 확인
    private func judgeSearchStock(status: Int, data: Data) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(SearchStock.self, from: data) else {
            return .pathErr
        }
        
        switch status {
        case 200:
            // 회원가입 성공
            return .success(decodedData)
        case 408:
            // 주식 API 문제로 요청 시간초과
            var overTimeMessage = "주식 API 문제로 요청 시간초과"
            return .requestErr(overTimeMessage)
        case 400:
            // 잘못된 파라미터
            return .wrongParameter
        default:
            return .networkFail
        }
    }
}
