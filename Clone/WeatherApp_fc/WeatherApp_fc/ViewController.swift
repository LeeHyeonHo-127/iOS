import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var minTemperatureLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var lonTextField: UITextField!
    @IBOutlet var latTextField: UITextField!
    @IBOutlet var weatherFeatureStackView: UIStackView!
    
    var lat: Double!//위도
    var lon: Double!//경도
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapFetchWeatherButton(_ sender: Any) {
        if let lat = self.latTextField.text{
            self.lat = Double(lat)
        }
        if let lon = self.lonTextField.text {
            self.lon = Double(lon)
        }
        
        self.getCurrentWeather(lon: self.lon, lat: self.lat, showAlert: self.showAlert2)
        self.view.endEditing(true)
    }
    
    func getCurrentWeather(lon:Double, lat:Double, showAlert: @escaping()-> Void){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=624da7d59c13943fa5aabdb14837ec95") else {return}
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){[weak self] data, response, error in
            //completionHandler closer. 매개변수로 data, response, error를 받는다
            // data는 서버에서 받은 데이터
            // reposense는 http 헤더 및 상태 코드 (응답 메타 데이터)
            // error 는 요청 실패시 받게 되는 에러 개체. 요청 실패시 nil이 반환
            let successRange = (200..<300)
            guard let data = data, error == nil else {return} //API를 받은 JSON 파일
            let decoder = JSONDecoder() //JSON 객체에서 데이터 유형으로 decode 하는 함수
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode){
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else {return}
                
                //decoder.decode 메서드에는 codable 프로토콜을 준수하는 구조체와 전달받은 데이터를 넣어준다. 이 코드를 통해 서버에서 받은 데이터를 구조체로 만든다.
                
                
                DispatchQueue.main.async {
                    //네트워크 작업은 별도의 쓰레드에서 동작한다. 때문에 UI 작업을 위해서는 main 쓰레드로 돌아와서 작업을 해야한다. 때문에 이 코드를 사용.
                    showAlert()
                    self?.weatherFeatureStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            }else{
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else {return}
                debugPrint(errorMessage)
            }
        }.resume()
    }
    
    func configureView(weatherInformation: WeatherInformation){
        if let weather = weatherInformation.weather.first{
            self.weatherDescriptionLabel.text = weather.description
        }
        self.currentTemperatureLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))'C"
        self.minTemperatureLabel.text = "최저 : \(Int(weatherInformation.temp.minTemp - 273.15))'C"
        self.maxTemperatureLabel.text = "최고 : \(Int(weatherInformation.temp.maxTemp - 273.15))'C"
    }
    

    func showAlert(message:String){
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert2(){
        let alert = UIAlertController(title: "날씨데이터가 잘 들어왔습니다.", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
  
}

