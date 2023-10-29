//
//  HomeTopView.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

protocol SetMapButtonDelegate: AnyObject {
    func setMapButtontapped(tappedButton: UIButton, beforeButton: UIButton, selectedView: UIView)
}

class HomeTopView: UIView{
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

extension HomeTopView: ViewCodeProtocol{
    func buildViewHierachy() {
        addSubview(logoView)
        logoView.addSubview(logoImageView)
        logoView.addSubview(logoLabel)
        addSubview(dateView)
        dateView.addSubview(dateLabel1)
        dateView.addSubview(dateLabel2)
        dateView.addSubview(locationImage)
        dateView.addSubview(locationLabel)
        dateView.addSubview(sectionButton)
        addSubview(buttonView)
        buttonView.addSubview(setTideMapButton)
        buttonView.addSubview(setWaterTempMapButton)
        buttonView.addSubview(setDepthOfWaterMapButton)
        buttonView.addSubview(setSaltMapButton)
        buttonView.addSubview(setFlowRateMapButton)
        addSubview(splitView)
        splitView.addSubview(showSelectedButtonView)
        
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
            make.width.equalTo(40)
            
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        //날짜 라벨2
        dateLabel2.snp.makeConstraints{ make in
            make.height.equalTo(16)
            make.width.equalTo(50)
            
            make.leading.equalTo(dateLabel1.snp.trailing).offset(3)
            make.top.equalTo(dateLabel1.snp.top)
        }
        
        //locationLabel
        locationLabel.snp.makeConstraints{ make in
            make.height.equalTo(16)
            make.width.equalTo(28)
            
            make.leading.equalTo(dateLabel1.snp.leading)
            make.top.equalTo(dateLabel1.snp.bottom).offset(8)
        }
        
        //locationImage
        locationImage.snp.makeConstraints{ make in
            make.height.width.equalTo(16)
            
            make.leading.equalTo(locationLabel.snp.trailing).offset(6)
            make.bottom.equalTo(locationLabel.snp.bottom)
        }
        
        //단면 버튼
        sectionButton.snp.makeConstraints{ make in
            make.height.equalTo(25)
            make.width.equalTo(41)
            
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        //버튼뷰
        buttonView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            
            make.top.equalTo(dateView.snp.bottom).offset(16)
        }
        
        //조석 버튼
        setTideMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)
                               
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            
            
        }
        
        //수온 버튼
        setWaterTempMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalToSuperview()
            make.leading.equalTo(setTideMapButton.snp.trailing)
        }
        
        //수심 버튼
        setDepthOfWaterMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalToSuperview()
            make.leading.equalTo(setWaterTempMapButton.snp.trailing)
        }
        
        //염분 버튼
        setSaltMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalToSuperview()
            make.leading.equalTo(setDepthOfWaterMapButton.snp.trailing)
        }
        
        //유속 버튼
        setFlowRateMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalToSuperview()
            make.leading.equalTo(setSaltMapButton.snp.trailing)
        }
        
        splitView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(1)

            make.top.equalTo(setFlowRateMapButton.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        showSelectedButtonView.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.height.equalTo(1)
            
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    func configureView() {
        logoImageView.image = UIImage(named: "logo")

        logoLabel.text = "씨플로우"
        logoLabel.font = UIFont.boldSystemFont(ofSize: 24)
        logoLabel.textColor = UIColor(named: "SeaFlowBlue")


        dateLabel1.text = "10/10"
        dateLabel1.font = UIFont.systemFont(ofSize: 16)
        dateLabel1.textColor = UIColor.black

        
        dateLabel2.text = "(10/10)"
        dateLabel2.font = UIFont.systemFont(ofSize: 16)
        dateLabel2.textColor = UIColor.black
        

        locationLabel.text = "전체"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 16)
        locationLabel.textColor = UIColor.black

        locationImage.image = UIImage(named: "location")


        sectionButton.setTitle("단면", for: .normal)
        sectionButton.setTitleColor(.white, for: .normal)
        sectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sectionButton.titleLabel?.textAlignment = .center
        sectionButton.layer.cornerRadius = 4
        sectionButton.backgroundColor = UIColor(named: "SeaFlowBlue")
        
        setTideMapButton.setTitle("조석", for: .normal)
        setTideMapButton.setTitleColor(UIColor(named: "SeaFlowBlue"), for: .normal)
        setTideMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTideMapButton.titleLabel?.textAlignment = .center
        setTideMapButton.backgroundColor = UIColor.white
        setTideMapButton.addTarget(self, action: #selector(setMapButtonTapped(_:)), for: .touchUpInside)
        setTideMapButton.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)
        
        setWaterTempMapButton.setTitle("수온", for: .normal)
        setWaterTempMapButton.setTitleColor(.black, for: .normal)
        setWaterTempMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setWaterTempMapButton.titleLabel?.textAlignment = .center
        setWaterTempMapButton.backgroundColor = UIColor.white
        setWaterTempMapButton.addTarget(self, action: #selector(setMapButtonTapped(_:)), for: .touchUpInside)
        setWaterTempMapButton.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)

        
        setDepthOfWaterMapButton.setTitle("수심", for: .normal)
        setDepthOfWaterMapButton.setTitleColor(.black, for: .normal)
        setDepthOfWaterMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setDepthOfWaterMapButton.titleLabel?.textAlignment = .center
        setDepthOfWaterMapButton.backgroundColor = UIColor.white
        setDepthOfWaterMapButton.addTarget(self, action: #selector(setMapButtonTapped(_:)), for: .touchUpInside)
        setDepthOfWaterMapButton.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)

        
        setSaltMapButton.setTitle("염분", for: .normal)
        setSaltMapButton.setTitleColor(.black, for: .normal)
        setSaltMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setSaltMapButton.titleLabel?.textAlignment = .center
        setSaltMapButton.backgroundColor = UIColor.white
        setSaltMapButton.addTarget(self, action: #selector(setMapButtonTapped(_:)), for: .touchUpInside)
        setSaltMapButton.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)
        
        setFlowRateMapButton.setTitle("유속", for: .normal)
        setFlowRateMapButton.setTitleColor(.black, for: .normal)
        setFlowRateMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setFlowRateMapButton.titleLabel?.textAlignment = .center
        setFlowRateMapButton.backgroundColor = UIColor.white
        setFlowRateMapButton.addTarget(self, action: #selector(setMapButtonTapped(_:)), for: .touchUpInside)
        setFlowRateMapButton.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)
        
        splitView.backgroundColor = .systemGray5
        
        showSelectedButtonView.backgroundColor = UIColor(named: "SeaFlowBlue")
        showSelectedButtonView.setContentHuggingPriority(.init(rawValue: 750), for: .horizontal)
    }
    
    @objc func setMapButtonTapped(_ sender: UIButton){
//        showSelectedButtonView.removeFromSuperview()
//        splitView.addSubview(showSelectedButtonView)
        
        delegate?.setMapButtontapped(tappedButton: sender, beforeButton: beforeButton!, selectedView: showSelectedButtonView)
        beforeButton = sender
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



