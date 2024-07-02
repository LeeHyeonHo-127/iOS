import UIKit

class StockCollectionViewFooter: UICollectionReusableView {
    
    let buttonHeight: CGFloat = 20
    let buttonSpacing: CGFloat = 5
    let buttonName = ["5일 예측", "10일 예측", "20일 예측", "30일 예측" ]
    var section: Int = 1
    let customBlueColor = UIColor(red: 0.3, green: 0.35, blue: 1.0, alpha: 1.0)
    var customBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButtons()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButtons()
    }
    
    //MARK: - 설정 함수
    
    //버튼 생성
    func configureButtons() {
        let buttonWidth = (bounds.width - (buttonSpacing * CGFloat(4 - 1))) / CGFloat(4)
        
        for index in 0..<4 {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: CGFloat(index) * (buttonWidth + buttonSpacing), y: 0, width: buttonWidth, height: buttonHeight)
            button.setTitle(self.buttonName[index], for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            button.layer.cornerRadius = 10
            
            // Gradient Layer 생성
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = button.bounds
                
            // 그라디언트 색상 설정
            let gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemBlue.cgColor] // 그라디언트에 사용할 색상 배열
            gradientLayer.colors = gradientColors
            
            // 그라디언트 방향 설정
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            
            
            // 그라디언트를 버튼의 배경색으로 설정
            button.layer.insertSublayer(gradientLayer, at: 0)
            button.tintColor = .white
            
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            addSubview(button)
        }
    }
    
    //버튼 동작
    @objc func buttonTapped(_ sender: UIButton) {
        guard let collectionView = superview as? UICollectionView else { return }

        // 해당 section의 cell을 찾아서 그래프 수치 변경
        let indexPaths = collectionView.indexPathsForVisibleItems.filter { $0.section == section }

        if let indexPath = indexPaths.first, let cell = collectionView.cellForItem(at: indexPath) as? ShowLeadingLineChartCell {
            // 버튼의 인덱스에 따라 다른 그래프 수치 변경 로직을 구현
            let buttonIndex = sender.tag
            
            switch buttonIndex {
            case 0:
                cell.datasetName = "5d_predict_SE00"
                cell.descriptionLabel.text = "5일주가 예측"
                cell.gradientColor = .systemCyan
                cell.isPredict = true
                cell.prepareForReuse()
            case 1:
                cell.datasetName = "10d_predict_SE00"
                cell.descriptionLabel.text = "10일 주가예측"
                cell.isPredict = true
                cell.prepareForReuse()
            case 2:
                cell.datasetName = "20d_predict_SE00"
                cell.descriptionLabel.text = "20일 주가예측"
                cell.isPredict = true
                cell.prepareForReuse()
            case 3:
                cell.datasetName = "30d_predict_SE00"
                cell.descriptionLabel.text = "30일 주가예측"
                cell.isPredict = true
                cell.prepareForReuse()
            default:
                break
            }
        
        }
    }
}

