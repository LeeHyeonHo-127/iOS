import UIKit


class TimeSeriesCollectionViewFooter: UICollectionReusableView{
    let button5 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let customBlueColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)

    override func layoutSubviews(){
        super.layoutSubviews()
        
        button5.setTitle("5일 주가예측", for: .normal)
        button2.setTitle("10일 주가예측", for: .normal)
        button3.setTitle("20일 주가예측", for: .normal)
        button4.setTitle("30일 주가예측", for: .normal)
        
//        button1.snp.makeConstraints{
//            $0.width = 30
//        }
        button5.layer.backgroundColor = customBlueColor.cgColor
        button2.layer.backgroundColor = customBlueColor.cgColor
        button3.layer.backgroundColor = customBlueColor.cgColor
        button4.layer.backgroundColor = customBlueColor.cgColor

        
        let stackView = UIStackView(arrangedSubviews: [button5, button2, button3, button4])
        stackView.layer.borderColor = customBlueColor.cgColor
        stackView.layer.borderWidth = 2
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        
        
//        configureButtons()
//        setupLayout()
    }
    
//    private func configureButtons() {
//        button1.setTitle("Button 1", for: .normal)
//        button2.setTitle("Button 2", for: .normal)
//        button3.setTitle("Button 3", for: .normal)
//        button4.setTitle("Button 4", for: .normal)
//
//        // 버튼에 대한 추가 설정
//        // ...
//    }
//
//    private func setupLayout() {
//        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.alignment = .center
//
//        addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
 
}
