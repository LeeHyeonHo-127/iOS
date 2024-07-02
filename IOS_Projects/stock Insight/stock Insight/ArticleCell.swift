import UIKit

class ArticleCell: UICollectionViewCell {
    var sourceLabel = UILabel()
    var titleLabel = UILabel()

    
    //layout SubView 설정
    override func layoutSubviews() {
        super.layoutSubviews()
        sourceLabel.text = "1"
        titleLabel.text = "2"
        addSubview(sourceLabel)
        addSubview(titleLabel)
        
        // 수직으로 정렬되는 Constraint 추가
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: topAnchor),
            sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            sourceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        print("============================")
        print("4. Article Cell Label Setting")
        print("Source Label : \(sourceLabel.text!)")
        print("Title Label : \(titleLabel.text!)")
    }

//    let sourceLabel: UILabel = {
//        let label = UILabel()
//        label.text = "1"
//        label.font = UIFont.systemFont(ofSize: 9)
//        label.tintColor = .black
//        label.textAlignment = .left
//        return label
//    }()

//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "2"
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.tintColor = .black
//        label.textAlignment = .left
//        return label
//    }()


//    private func setupViews() {
//        addSubview(sourceLabel)
//        addSubview(titleLabel)
//    }
}

