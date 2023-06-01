import UIKit
import SnapKit
import Charts


class ShowLineChartCell: UICollectionViewCell{
    var lineChartView: LineChartView!
    var descriptionLabel = UILabel()
    var kospiData: [Double] = []
    let customBlueColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)
    var gradientColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)
    var num = 1

    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    func configureChartView(){
        //contentView = cell의 내용을 표시하는 뷰
        //contentView 설정
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true //conentView 를 넘어가는 하위 뷰 요소를 자른다.
        // 그라디언트 채우기 설정
        let gradientColor = gradientColor
        let gradientColors = [gradientColor.cgColor, UIColor.white.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: gradientColors,
                                        locations: colorLocations) else {
            fatalError("그라디언트 생성 실패했습니다.")
        }
        
        
        
        // 데이터 엔트리 생성
        var entries: [ChartDataEntry] = []
        for (index, value) in kospiData.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: value)
            entries.append(entry)
        }

        // 데이터셋 생성
        let dataSet = LineChartDataSet(entries: entries, label: "KOSPI")
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
        
        
        // 차트 뷰 설정
        lineChartView = LineChartView(frame: contentView.bounds)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false //autoLayout 지정 속성_ fals = autuLayout 사용
        contentView.addSubview(lineChartView)
        lineChartView.contentMode = .scaleToFill
        
        lineChartView.data = data
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        
        
        lineChartView.xAxis.labelPosition = .bottom // x축 레이블 위치 설정
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: []) // x축 레이블 포맷터 설정 (일단 빈 값으로 설정)
        lineChartView.rightAxis.enabled = false // 오른쪽 축 비활성화
        lineChartView.legend.enabled = false // 범례 비활성화
        lineChartView.chartDescription.enabled = false // 차트 설명 비활성화
        lineChartView.pinchZoomEnabled = false        // 핀치 줌 기능 비활성화
        lineChartView.scaleXEnabled = false           // X축 스케일 기능 비활성화
        lineChartView.scaleYEnabled = false           // Y축 스케일 기능 비활성화
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.isUserInteractionEnabled = false
        lineChartView.noDataText = ""

        //descrpitionLabel
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .bold)
        descriptionLabel.textColor = .black
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(0)
        }
        
    }
}
