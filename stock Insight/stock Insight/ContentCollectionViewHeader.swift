import UIKit

class ContentCollectionViewHeader: UICollectionReusableView{
    let sectionNameLabel = UILabel()
    let StockDetailViewButtonTapped = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        
        StockDetailViewButtonTapped.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        StockDetailViewButtonTapped.tintColor = .black
        
        
        addSubview(sectionNameLabel)
        addSubview(StockDetailViewButtonTapped)
        
        sectionNameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
        
        StockDetailViewButtonTapped.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
