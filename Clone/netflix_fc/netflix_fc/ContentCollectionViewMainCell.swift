import UIKit

class ContentCollectionViewMainCell: UICollectionViewCell{
    let baseStackView = UIStackView()
    let menuStakView = UIStackView()
    
    let tvButton = UIButton()
    let moviewbutton = UIButton()
    let categoryButton = UIButton()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStakView].forEach{
            contentView.addSubview($0)
        }
        [imageView, descriptionLabel, contentStackView].forEach{
            baseStackView.addArrangedSubview($0)
        }
        
        
        //baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        baseStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        
        //imageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints{
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        //descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        //ContentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        [plusButton, playButton, infoButton].forEach{
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        [plusButton, infoButton].forEach{
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
            
        }
        
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        playButton.setTitle("▶︎ 재생", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints{
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        
        //menuStackView
        menuStakView.axis = .horizontal
        menuStakView.alignment = .center
        menuStakView.distribution = .equalSpacing
        menuStakView.spacing = 20
        
        menuStakView.snp.makeConstraints{
            $0.top.equalTo(baseStackView)
            $0.leading.equalToSuperview().inset(30)
        }
        
        //menuStackViewButton
        [tvButton, moviewbutton, categoryButton].forEach{
            menuStakView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        moviewbutton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리", for: .normal)
        
        tvButton.addTarget(self, action: #selector(tvButtonTapped), for: .touchUpInside)
        moviewbutton.addTarget(self, action: #selector(moviebuttonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)


    }
        
        
    @objc func tvButtonTapped(sender: UIButton!){
        print("TVButton 이 눌렸습니다")
    }
    @objc func moviebuttonTapped(sender: UIButton!){
        print("moviewButton 이 눌렸습니다")
    }
    @objc func categoryButtonTapped(sender: UIButton!){
        print("categoryButton 이 눌렸습니다")
    }
    @objc func plusButtonTapped(sender: UIButton!){
        print("plusbutton 이 눌렸습니다")
    }
    @objc func infoButtonTapped(sender: UIButton!){
        print("infoButton 이 눌렸습니다")
    }
    @objc func playButtonTapped(sender: UIButton!){
        print("playButton 이 눌렸습니다")
    }
        
    
}

extension UIButton {
    func adjustVerticalLayout(_ spacing: CGFloat = 0) {
        let imageSize = self.imageView?.frame.size ?? .zero
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        let titleLabelSize = self.titleLabel?.frame.size ?? .zero
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleLabelSize.height + spacing), left: 0, bottom: 0, right: -titleLabelSize.width)
    }
}

