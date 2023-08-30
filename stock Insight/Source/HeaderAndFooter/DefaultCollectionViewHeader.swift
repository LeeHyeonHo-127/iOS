import UIKit

class DefaultCollectionViewHeader: UICollectionReusableView{
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeLabel_And_Button()
    }
    
    
    //MARK: - 설정 함수
    
    //nameLabel, Button 생성
    func makeLabel_And_Button(){
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        let customBlueColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)
        
        addSubview(sectionNameLabel)
        
        //constraint 설정
        sectionNameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
