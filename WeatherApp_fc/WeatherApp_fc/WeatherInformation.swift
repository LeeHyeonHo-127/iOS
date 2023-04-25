import Foundation

struct WeatherInformation: Codable{
    let weather: [Weather]
    let temp: Temp
    
    
    enum CodingKeys: String, CodingKey{
        case weather
        case temp = "main"
    }
}

struct Weather: Codable{ //JSON 구조의 데이터 이름과 구조체의 프로퍼티 아이디를 같게 만들어서 JSON 파일을 사용한다.
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable{
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey { //JSON 구조의 데이터이름과 구초체의 프로퍼티 아이디가 다를 때 사용하는 방법
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
