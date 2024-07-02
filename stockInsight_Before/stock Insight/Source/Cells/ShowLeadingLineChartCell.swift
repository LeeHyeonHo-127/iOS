import UIKit
import SnapKit
import Charts


class ShowLeadingLineChartCell: UICollectionViewCell{
    var lineChartView: LineChartView!
    
    var descriptionLabel = UILabel()
    var stockData: [[String: Double]] = [[:]]
    let customBlueColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)
    var gradientColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)
    var section:Int = 0
    
    var datasetName: String = "dataset_SE"
    var num = 1
    var isPredict = false

    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        if lineChartView == nil {
            self.lineChartView = configureChartView(isPredict: isPredict)
            setContentView()
            contentView.addSubview(lineChartView)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleChartTap(_:)))
            lineChartView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    //재사용셀 설정
    override func prepareForReuse() {
        super.prepareForReuse()
        // 이전에 추가된 하위 뷰들을 제거
        lineChartView?.clear()
        self.lineChartView = configureChartView(isPredict: isPredict)
        setContentView()
        contentView.addSubview(lineChartView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleChartTap(_:)))
        lineChartView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    
    @objc func handleChartTap(_ gesture: UITapGestureRecognizer) {
        self.handleChartZoom()
    }
    
    //MARK: - 설정 함수
    
    //ContentView 설정
    func setContentView(){
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true //conentView 를 넘어가는 하위 뷰 요소를 자른다.
    }
    

    //chartView 설정
    func configureChartView(isPredict: Bool) -> LineChartView{
        let gradient = fillGradient()
        let data = setDataEntry()
        let lineChartView = setLineChartView()
        lineChartView.data = data // 데이터 설정

        return lineChartView
        
        // 그라디언트 채우기 설정
        func fillGradient()-> CGGradient{
            let gradientColor = gradientColor
            let gradientColors = [gradientColor.cgColor, UIColor.white.cgColor] as CFArray
            let colorLocations: [CGFloat] = [1.0, 0.0]
            guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                            colors: gradientColors,
                                            locations: colorLocations) else {
                fatalError("그라디언트 생성 실패했습니다.")
            }
            return gradient
        }
        // 데이터 엔트리 생성
        func setDataEntry()-> LineChartData{
            var entries: [ChartDataEntry] = []
            var stockData = parseCSVFile(datasetName: self.datasetName)
            if(section == 1){
                for entry in stockData {
                    if let date = entry.keys.first, let value = entry.values.first {
                        let xValue = date.timeIntervalSince1970
                        let yValue = value
                        let dataEntry = ChartDataEntry(x: xValue, y: yValue)
                        entries.append(dataEntry)
                    }
                }
            }else{
                for entry in stockData {
                    if let date = entry.keys.first, let value = entry.values.first {
                        let xValue = date.timeIntervalSince1970
                        let yValue = value
                        let dataEntry = ChartDataEntry(x: xValue, y: yValue)
                        entries.append(dataEntry)
                    }
                }
            }

            

            // 데이터셋 생성
            let dataSet = LineChartDataSet(entries: entries, label: "data")
            dataSet.setColor(gradientColor) // 그래프 선 색상 설정
            dataSet.lineWidth = 1.0 // 그래프 선 두께 설정
            dataSet.drawCirclesEnabled = false // 데이터 포인트에 원형 마커 표시 여부 설정
            dataSet.drawValuesEnabled = true //
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
            dataSet.drawFilledEnabled = true // 채우기 활성화
            dataSet.mode = .cubicBezier
            dataSet.cubicIntensity = 0.2

            // 데이터 배열 설정
            let data = LineChartData(dataSet: dataSet)
            return data
        }
        
        
        //lineChartView 생성
        func setLineChartView()->LineChartView{
            // 차트 뷰 설정
            var lineChartView = LineChartView(frame: contentView.bounds)
            lineChartView.translatesAutoresizingMaskIntoConstraints = false //autoLayout 지정 속성_ fals = autuLayout 사용
            lineChartView.contentMode = .scaleToFill
            
            //차트 뷰 데이터 설정
            lineChartView.data = data
            
            //차트 뷰 grid 설정
            lineChartView.xAxis.drawGridLinesEnabled = false
            lineChartView.leftAxis.drawGridLinesEnabled = false
            
            //차트 뷰 뷰 설정
            lineChartView.xAxis.labelPosition = .bottom // x축 레이블 위치 설정
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: []) // x축 레이블 포맷터 설정 (일단 빈 값으로 설정)
            lineChartView.rightAxis.enabled = false // 오른쪽 축 비활성화
            lineChartView.legend.enabled = false // 범례 비활성화
            lineChartView.chartDescription.enabled = false // 차트 설명 비활성화
            lineChartView.pinchZoomEnabled = true        // 핀치 줌 기능 비활성화
            lineChartView.scaleXEnabled = true           // X축 스케일 기능 비활성화
            lineChartView.scaleYEnabled = true           // Y축 스케일 기능 비활성화
            lineChartView.doubleTapToZoomEnabled = true
            lineChartView.isUserInteractionEnabled = true
            lineChartView.noDataText = "" //데이터 없을 때 보일 문자열
            lineChartView.xAxis.valueFormatter = DateAxisValueFormatter()
            
            lineChartView.xAxis.labelCount = 7 // x축 레이블 개수 설정
            lineChartView.xAxis.granularity = 1 // x축 레이블 간격 설정
            lineChartView.xAxis.labelRotationAngle = -45 // x축 레이블 회전 설정
            if lineChartView.scaleX >= 2.0 && lineChartView.scaleY >= 2.0 {
                lineChartView.data?.setDrawValues(true) // 그래프에 값 표시 활성화
            } else {
                lineChartView.data?.setDrawValues(false) // 그래프에 값 표시 비활성화
            }
            
            
            let dateString = "2023/06/07"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = dateFormatter.date(from: dateString)
            let doubleValue = date?.timeIntervalSince1970
            
            if isPredict == true{
                let limitLine = ChartLimitLine(limit: doubleValue!, label: "") // 특정 x 값에 대한 제한선 생성
                limitLine.lineWidth = 1 // 제한선의 너비 설정
                limitLine.lineColor = .systemRed // 제한선의 색상 설정
                lineChartView.xAxis.addLimitLine(limitLine) // 제한선을 왼쪽 축에 추가
                lineChartView.notifyDataSetChanged()
                lineChartView.setNeedsDisplay()
            }
            
    

            //descrpitionLabel
            descriptionLabel.font = .systemFont(ofSize: 15, weight: .bold)
            descriptionLabel.textColor = .black
            contentView.addSubview(descriptionLabel)
            descriptionLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(10)
            }
            return lineChartView
        }
    }
    

    
    
    //MARK: - 기타함수
    
    //줌 배율별 drawValue 설정
    func handleChartZoom() {
        if lineChartView.scaleX >= 2.0 && lineChartView.scaleY >= 2.0 {
            lineChartView.data?.setDrawValues(true) // 그래프에 값 표시 활성화
        } else {
            lineChartView.data?.setDrawValues(false) // 그래프에 값 표시 비활성화
        }
    }
    
    //CSV 파싱
    func parseCSVFile(datasetName: String) -> [[Date: Double]] {
        var dictionaryArray: [[Date: Double]] = []

        guard let path = Bundle.main.path(forResource: datasetName, ofType: "csv") else {
            return dictionaryArray
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: .utf8)
            let lines = csvString.components(separatedBy: "\n")

            let trimmedLines = lines.map { line -> String in
                var trimmedLine = line
                if let commaIndex = line.firstIndex(of: ",") {
                    let startIndex = line.index(after: commaIndex)
                    trimmedLine = String(line[startIndex...])
                }
                return trimmedLine
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

            for line in trimmedLines[1...] {
                let temp = line.components(separatedBy: ",")
                let fields = temp.map { $0.replacingOccurrences(of: "\r", with: "") }

                if let dateString = fields.first, let valueString = fields.last,
                   let date = dateFormatter.date(from: dateString),
                   let value = Double(valueString) {
                    let dictionary: [Date: Double] = [date: value]
                    dictionaryArray.append(dictionary)
                }
            }
        } catch {
            print("Error reading CSV file: \(error)")
        }
        return dictionaryArray
    }
    
}

