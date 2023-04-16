import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var minTemperatureLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var lonTextField: UITextField!
    @IBOutlet var latTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getCurrentWeather(lon:Double, lat:Double){
        guard let lat = latTextField!.text else {return}
        guard let lon = lonTextField!.text else {return}
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=5b94ed0b9f14c10d74778b3665f1e893") else {return}
    }
    
  
}

