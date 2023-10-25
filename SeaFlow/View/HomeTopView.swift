//
//  HomeTopView.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class HomeTopView: UIView{
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "씨플로우"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(named: "SeaFlowBlue")
        return label
    }()
    
    lazy var dateLabel1: UILabel = {
        let label = UILabel()
        label.text = "10/10"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var dateLabel2: UILabel = {
        let label = UILabel()
        label.text = "(10/10)"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location")
        return imageView
    }()

    
    lazy var sectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("단면", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(named: "SeaFlowBlue")
        return button
        
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(logoImageView)
        addSubview(logoLabel)
        addSubview(dateLabel1)
        addSubview(dateLabel2)
        addSubview(locationImage)
        addSubview(locationLabel)
        addSubview(sectionButton)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        //로고 이미지
        logoImageView.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview()
        }
        //로고 라벨
        logoLabel.snp.makeConstraints{ make in
            make.height.equalTo(24)
            
            make.leading.equalTo(logoImageView.snp.trailing).offset(5)
            make.top.equalToSuperview()
        }
        
        //날짜 라벨1
        dateLabel1.snp.makeConstraints{ make in
            make.height.equalTo(16)
            
            make.leading.equalTo(logoImageView.snp.leading).offset(5)
            make.top.equalTo(logoLabel.snp.bottom).offset(25)
        }
        
        //날짜 라벨2
        dateLabel2.snp.makeConstraints{ make in
            make.height.equalTo(16)
            
            make.leading.equalTo(dateLabel1.snp.trailing).offset(3)
            make.top.equalTo(dateLabel1.snp.top)
        }
        
        //locationLabel
        locationLabel.snp.makeConstraints{ make in
            make.height.equalTo(16)
            
            make.leading.equalTo(dateLabel1.snp.leading)
            make.top.equalTo(dateLabel1.snp.bottom).offset(5)
        }
        
        //locationImage
        locationImage.snp.makeConstraints{ make in
            make.height.width.equalTo(16)
            
            make.leading.equalTo(locationLabel.snp.trailing)
            make.top.equalTo(dateLabel1.snp.bottom).offset(5)
        }
        
        //sectionButton
        sectionButton.snp.makeConstraints{ make in
            make.height.equalTo(25)
            make.width.equalTo(41)
            
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(dateLabel1.snp.top).offset(5)
        }
    }
    
    
}




#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ItemTableViewCellPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = HomeTopView()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
