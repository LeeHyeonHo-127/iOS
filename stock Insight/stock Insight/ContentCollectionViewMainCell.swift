import UIKit
import Charts


class ContentCollectionViewMainCell: UICollectionViewCell{
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    var chartView: CandleStickChartView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        chartView = CandleStickChartView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        contentView.addSubview(chartView)
        
        // 데이터 생성
        let entries = [
            CandleChartDataEntry(x: 0, shadowH: 50, shadowL: 30, open: 40, close: 35),
            CandleChartDataEntry(x: 1, shadowH: 55, shadowL: 32, open: 37, close: 43),
            CandleChartDataEntry(x: 2, shadowH: 58, shadowL: 35, open: 42, close: 39),
            // 추가적인 데이터 엔트리 추가 가능
        ]

        // 데이터셋 생성
        let dataSet = CandleChartDataSet(entries: entries, label: "Candle Dataset")

        // 데이터셋 스타일 설정
        dataSet.axisDependency = .left
        dataSet.shadowColor = .darkGray
        dataSet.shadowWidth = 0.7
        dataSet.decreasingColor = .red
        dataSet.decreasingFilled = true
        dataSet.increasingColor = .green
        dataSet.increasingFilled = true
        dataSet.neutralColor = .blue

        // 차트 데이터 생성
        let data = CandleChartData(dataSet: dataSet)

        // 차트에 데이터 적용
        chartView.data = data
        
        //contentView
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        //chartView
        chartView.contentMode = .scaleToFill
        chartView.snp.makeConstraints{
            $0.trailing.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(20)
            $0.width.equalToSuperview().offset(10)
        }
        
        //rankLabel
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.textColor = .black
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(25)
        }
    }

}
       
    
        
    




