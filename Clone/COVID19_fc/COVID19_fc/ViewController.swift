
import UIKit
import Alamofire
import Charts

class ViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var newCaseLabel: UILabel!
    @IBOutlet var totalCaseLabel: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        self.stackView.isHidden = true
        self.fetchCovidOverView(completionHadler: { [weak self] result in
            self?.indicatorView.stopAnimating()
            self?.indicatorView.isHidden = true
            self?.stackView.isHidden = false
            self?.pieChartView.isHidden = false

            switch result{
            case let .success(result):
                self?.configureStackView(koreaCovidOverview: result.korea)
                guard let covidOverViewList = self?.getList(cityCovidOverView: result) else {return}
                self?.configureChartView(covidOverviewList: covidOverViewList)
            case let .failure(error):
                debugPrint("통신 실패ㅠㅠ \(error)")
            }
        })
    }
    
    func fetchCovidOverView(completionHadler: @escaping (Result<CityCovidOverview, Error>) -> Void ){
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "4T2mHsoCMr79J6ewNuWxV8DvGfYLpy1QK"
        ]
        
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: { response in
            switch response.result{
            case let .success(data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    completionHadler(.success(result))
                }catch{
                    completionHadler(.failure(error))
                }
            case let .failure(error):
                completionHadler(.failure(error))
            }
    })
}
    func configureStackView(koreaCovidOverview: CovidOverview) {
      self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase) 명"
      self.newCaseLabel.text = "\(koreaCovidOverview.newCase) 명"
    }
    
    func getList(cityCovidOverView: CityCovidOverview) -> [CovidOverview]{
        return [
            cityCovidOverView.seoul,
            cityCovidOverView.busan,
            cityCovidOverView.chungbuk,
            cityCovidOverView.chungnam,
            cityCovidOverView.daegu,
            cityCovidOverView.daejeon,
            cityCovidOverView.gwangju,
            cityCovidOverView.gyeonggi,
            cityCovidOverView.gyeongnam,
            cityCovidOverView.gyeongbuk,
            cityCovidOverView.incheon,
            cityCovidOverView.jeju,
            cityCovidOverView.jeonbuk,
            cityCovidOverView.jeonnam,
            cityCovidOverView.sejong,
            cityCovidOverView.ulsan
        ]
    }
    func configureChartView(covidOverviewList: [CovidOverview]){
        self.pieChartView.delegate = self

        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry in
            guard let self = self else { return PieChartDataEntry() }
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueTextColor = .black
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        
        dataSet.colors = ChartColorTemplates.vordiplom()
          + ChartColorTemplates.joyful()
          + ChartColorTemplates.colorful()
          + ChartColorTemplates.liberty()
          + ChartColorTemplates.pastel()
          + ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: pieChartView.rotationAngle, toAngle: pieChartView.rotationAngle + 80)

    }
    
    func removeFormatString(string: String) -> Double {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter.number(from: string)?.doubleValue ?? 0
    }
}

extension ViewController: ChartViewDelegate {
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    guard let covidDetailViewController = self.storyboard?.instantiateViewController(identifier: "CovidDetailViewController") as? CovidDetailViewController else {
         return
       }
    guard let covidOverview = entry.data as? CovidOverview else { return }
    covidDetailViewController.covidOverview = covidOverview
    self.navigationController?.pushViewController(covidDetailViewController, animated: true)
  }
}


