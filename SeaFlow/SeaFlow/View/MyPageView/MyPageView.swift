//
//  HomeTopView.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit


class MyPageView: UIView{
    lazy var logoView = UIView()
    lazy var dateView = UIView()
    
    lazy var logoImageView = UIImageView()
    lazy var logoLabel = UILabel()
    lazy var dateLabel1 = UILabel()
    lazy var dateLabel2 = UILabel()
    lazy var locationLabel = UILabel()
    lazy var locationImage: UIImageView = UIImageView()
    lazy var sectionButton: UIButton = UIButton()
    
    lazy var buttonView = UIView()
    lazy var setTideMapButton = UIButton()
    lazy var setWaterTempMapButton = UIButton()
    lazy var setDepthOfWaterMapButton = UIButton()
    lazy var setSaltMapButton = UIButton()
    lazy var setFlowRateMapButton = UIButton()
    lazy var splitView = UIView()
    lazy var showSelectedButtonView = UIView()
    
    lazy var personImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    lazy var dummyImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "myPageDummyImage")
        return imageView
    }()
    
    weak var delegate: SetMapButtonDelegate?
    var beforeButton: UIButton?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        beforeButton = setTideMapButton
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageView: ViewCodeProtocol{
    func buildViewHierachy() {
        addSubview(logoView)
        logoView.addSubview(logoImageView)
        logoView.addSubview(logoLabel)
        addSubview(dateView)
        dateView.addSubview(dateLabel1)
        dateView.addSubview(locationLabel)
        addSubview(personImageView)
        addSubview(dummyImage)
        
        
    }
    
    func setUpConstraint() {
        
        //로고 컨테이너 뷰
        logoView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(48)
            
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        //로고 이미지
        logoImageView.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(12)
        }
        
        //로고 라벨
        logoLabel.snp.makeConstraints{ make in
            make.height.equalTo(24)
            
            make.leading.equalTo(logoImageView.snp.trailing).offset(5)
            make.top.equalTo(logoImageView.snp.top)
        }
        
        //날짜 컨테이너 뷰
        dateView.snp.makeConstraints{ make in
            make.width.equalToSuperview().offset(-47)
            make.height.equalTo(40)
            
            make.top.equalTo(logoView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
        }
        
        //날짜 라벨1
        dateLabel1.snp.makeConstraints{ make in
            make.height.equalTo(16)
            make.width.equalTo(100)
            
            make.leading.equalToSuperview().offset(60)
            make.top.equalToSuperview()
        }
        

        
        //locationLabel
        locationLabel.snp.makeConstraints{ make in
            make.height.equalTo(16)
            make.width.equalTo(200)
            
            make.leading.equalTo(dateLabel1.snp.leading)
            make.top.equalTo(dateLabel1.snp.bottom).offset(8)
        }
        
        personImageView.snp.makeConstraints{ make in
            make.width.height.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(locationLabel.snp.bottom).offset(10)
        }
        
        dummyImage.snp.makeConstraints{make in
            make.width.equalToSuperview()
            make.height.equalTo(270)
            make.top.equalTo(personImageView.snp.bottom).offset(10)
        }

        
  
        
    
    }
    
    func configureView() {
        logoImageView.image = UIImage(named: "logo")
        
        logoLabel.text = "씨플로우"
        logoLabel.font = UIFont.boldSystemFont(ofSize: 24)
        logoLabel.textColor = UIColor(named: "SeaFlowBlue")
        
        
        dateLabel1.text = "이현호"
        dateLabel1.font = UIFont.systemFont(ofSize: 16)
        dateLabel1.textColor = UIColor.black
        
        
        locationLabel.text = "010-1234-1234"
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textColor = UIColor.systemGray
        
    
        
        
        
        
        
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MyPageViewPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = MyPageView()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif



