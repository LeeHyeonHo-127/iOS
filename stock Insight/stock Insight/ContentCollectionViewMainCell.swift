import UIKit
import Charts


class ContentCollectionViewMainCell: UICollectionViewCell{
    let descriptionLabel = UILabel()
    var chartView: CandleStickChartView!
    // Apple 주가 데이터 (예시 데이터)
    var applePrices: [(date: Date, open: Double, high: Double, low: Double, close: Double)] = []
    

    override func prepareForReuse() {
        super.prepareForReuse()
        chartView.removeFromSuperview()

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        chartView = CandleStickChartView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height))
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.cornerRadius = 10
        
        // 데이터셋 생성
        var entries: [CandleChartDataEntry] = []
        
        for (index, price) in applePrices.enumerated() {
            let entry = CandleChartDataEntry(x: Double(index), shadowH: price.high, shadowL: price.low, open: price.open, close: price.close)
            entries.append(entry)
        }
        
        let dataSet = CandleChartDataSet(entries: entries, label: "Apple Stock")
        
        // 데이터 색상 및 스타일 설정
        dataSet.colors = [UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0)]
        dataSet.shadowColorSameAsCandle = true
        dataSet.decreasingColor = UIColor.red
        dataSet.decreasingFilled = true
        dataSet.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1.0)
        dataSet.increasingFilled = false
        dataSet.neutralColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0)
        
        // 데이터 배열 설정
        let data = CandleChartData(dataSets: [dataSet])
        
        // 차트 뷰 설정
        chartView.data = data
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false

        
        chartView.xAxis.labelPosition = .bottom // x축 레이블 위치 설정
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: []) // x축 레이블 포맷터 설정 (일단 빈 값으로 설정)
        chartView.rightAxis.enabled = false // 오른쪽 축 비활성화
        chartView.legend.enabled = false // 범례 비활성화
        chartView.chartDescription.enabled = false // 차트 설명 비활성화
        
        let xValues = (1...applePrices.count).map { "\($0)일" }
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        
        // 차트 애니메이션 설정 (선택사항)
        chartView.animate(xAxisDuration: 1.0)
        
        contentView.addSubview(chartView)

        chartView.contentMode = .scaleToFill
        chartView.snp.makeConstraints{
            $0.trailing.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(5)
            $0.width.equalToSuperview().offset(0)
        }
        //descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .bold)
        descriptionLabel.textColor = .black
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(0)
        }
    }

}
       
    
        
    




