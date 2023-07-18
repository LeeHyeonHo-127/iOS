import UIKit

class ArticleCell: UICollectionViewCell {
    
    var artitleURL = ""
    var titleLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 290, height: 30))
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    var button: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        var chevronImage = UIImage(systemName: "chevron.right")
        button.setImage(chevronImage, for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(gotoArticle), for: .touchDown)
        return button
    }()
    
    @objc func gotoArticle(){
        let websiteURL = URL(string: artitleURL)
        if let url = websiteURL {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
    }
    

    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let horizontalStackView1 = UIStackView(arrangedSubviews: [titleLabel, button])
        horizontalStackView1.axis = .horizontal
        horizontalStackView1.spacing = 33

        contentView.addSubview(horizontalStackView1)
        
        horizontalStackView1.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}

