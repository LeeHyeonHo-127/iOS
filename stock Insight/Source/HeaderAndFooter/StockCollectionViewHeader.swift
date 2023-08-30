import UIKit

protocol StockCollectionViewHeaderDelegate: AnyObject {
    func didTapStockDetailView()
}

class StockCollectionViewHeader: UICollectionReusableView{
    let sectionNameLabel = UILabel()
    let StockDetailViewButtonTapped = UIButton()
    weak var delegate: StockCollectionViewHeaderDelegate?

    
    //subView 설정
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeLabel_And_Button()
    }
    
    
    //MARK: - 설정함수
    
    //nameLabel, Button 생성, 추가
    func makeLabel_And_Button(){
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()

        StockDetailViewButtonTapped.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        StockDetailViewButtonTapped.tintColor = .systemBlue
        StockDetailViewButtonTapped.addTarget(self, action: #selector(moveToStockDetailViewController), for: .touchDown)
        
        addSubview(sectionNameLabel)
        addSubview(StockDetailViewButtonTapped)
        
        
        //constraint 지정
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
    

    //MARK: - 기타 함수
    
    
    //버튼 눌릴시 종목 상세화면으로 이동
    @objc func moveToStockDetailViewController(){
//        guard let collectionView = superview as? UICollectionView else { return }
//        
//        let indexPaths = collectionView.indexPathsForVisibleItems.filter { $0.section == 0 }
//        if let indexPath = indexPaths.first, let cell = collectionView.cellForItem(at: indexPath) as? ShowLineChartCell{
//            cell.prepareForReuse()
//        }
//        
//        let indexPaths2 = collectionView.indexPathsForVisibleItems.filter { $0.section == 1 }
//        
//        if let indexPath2 = indexPaths2.first, let cell = collectionView.cellForItem(at: indexPath2) as? ShowLeadingLineChartCell{
//            cell.prepareForReuse()
//        }
        delegate?.didTapStockDetailView()
    }
}
