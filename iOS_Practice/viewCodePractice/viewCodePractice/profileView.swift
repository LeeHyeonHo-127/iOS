import UIKit

// ProfileView.swift
private enum Constants {
    static let imageLeading: CGFloat = 16
    static let imageHeight: CGFloat = 80
    static let imageWidth: CGFloat = 80
    static let imageToStackSpacing: CGFloat = 48
    static let stackTop: CGFloat = 8
    static let stackBotton: CGFloat = -8
    static let stackTrailing: CGFloat = -8
}


class ProfileView: UIView {
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
//       self.viewModel = viewModel
       super.init(frame: frame)
       applyViewCode()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Custom Data
    public struct ViewModel {
        let image: String
        let name: String
        let age: String
        let occupation: String
        let gender: String
        
        public init(image: String,
                    name: String,
                    age: String,
                    occupation: String,
                    gender: String) {
            self.image = image
            self.name = name
            self.age = age
            self.occupation = occupation
            self.gender = gender
        }
    }
}

extension ProfileView: ViewCodeProtocol {
    func buildViewHierachy() {
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(occupationLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(genderLabel)
    }
    
    func setUpConstraint() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageLeading),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.stackTop),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.imageToStackSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.stackTrailing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.stackBotton)
        ])
    }
    
    func congigureView() {
        print("hello")
//        imageView.image = UIImage(named: viewModel.image)
//        nameLabel.text = viewModel.name
//        occupationLabel.text = viewModel.occupation
//        ageLabel.text = viewModel.age
//        genderLabel.text = viewModel.gender
//        backgroundColor = .white
//        // 루트 뷰의 속성 중 일부도 설정하고 있습니다. 더 적절한 위치가 없다고 설명을 함
//        layer.cornerRadius = 8
//        layer.borderWidth = 1
    }
}
