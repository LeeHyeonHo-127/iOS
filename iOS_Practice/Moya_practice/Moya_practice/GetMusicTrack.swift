
import Foundation
import Alamofire


struct GetMusicTrack{
    static let share = GetMusicTrack()
    
    func getTrack(completionHandler: @escaping (Result<MusicTrack, Error>) -> Void){
        let url = "https://itunes.apple.com/us/lookup"
        let param = ["id" : "1612758101"]
        
        let request = AF.request(url, method: .get, parameters: param)
        request.responseData(completionHandler: {response in
            switch response.result{
            case let .success(data):
                do{
                    print("success")
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MusicTrack.self, from: data)
                    completionHandler(.success(result))
                }catch{
                    print("success - failure")
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                print("failure")
                completionHandler(.failure(error))
            }
        })
        
    }
}
