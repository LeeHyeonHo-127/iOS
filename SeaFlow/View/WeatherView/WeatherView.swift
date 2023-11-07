//
//  HomeTopView.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class WeatherView: UIView{
    
    var myView = UIView()


    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rainyImage")
        return imageView
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "14.6°C"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var highestAndLowestTempLabel: UILabel = {
        let label = UILabel()
        label.text = "최저 12.0°C / 최고 15.0°C"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var waveHeightLabel: UILabel = {
        let label = UILabel()
        label.text = "파고 0m"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var windSpeendLabel: UILabel = {
        let label = UILabel()
        label.text = "풍속 북서 15m/s"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()

    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(weatherImageView)
        addSubview(tempLabel)
        addSubview(highestAndLowestTempLabel)
        addSubview(waveHeightLabel)
        addSubview(windSpeendLabel)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setUI(){
        //날씨 이미지
        weatherImageView.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            
            make.centerX.equalTo(tempLabel)
            make.top.equalToSuperview()
        }
        //온도
        tempLabel.snp.makeConstraints{ make in
            make.height.equalTo(14)
            
            
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(weatherImageView.snp.bottom).offset(8)
        }
        
        //날짜 라벨1
        highestAndLowestTempLabel.snp.makeConstraints{ make in
            make.height.equalTo(12)
            
            make.leading.equalTo(tempLabel.snp.trailing).offset(8)
            make.top.equalTo(weatherImageView.snp.top)
        }
        
        //날짜 라벨1
        waveHeightLabel.snp.makeConstraints{ make in
            make.height.equalTo(12)
            
            make.leading.equalTo(tempLabel.snp.trailing).offset(8)
            make.top.equalTo(highestAndLowestTempLabel.snp.bottom).offset(4)
        }
        
        windSpeendLabel.snp.makeConstraints{ make in
            make.height.equalTo(12)
            
            make.leading.equalTo(tempLabel.snp.trailing).offset(8)
            make.top.equalTo(waveHeightLabel.snp.bottom).offset(4)
        }

    }
    
    
}




#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct WeatherViewPreView: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = WeatherView()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
