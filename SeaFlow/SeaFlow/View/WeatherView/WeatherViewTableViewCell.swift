//
//  TableViewCell.swift
//  Danggeun
//
//  Created by 이현호 on 2023/10/11.
//

import UIKit
import SnapKit

class WeatherViewTableViewCell: UITableViewCell {
    lazy var containerView = UIView()
    
    
    
    lazy var timeLabel: UILabel = {
        var label = UILabel()
        
        label.text = "0시"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        var label = UILabel()
        
        label.text = "14°C"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var waveHeightLabel: UILabel = {
        var label = UILabel()
        
        label.text = "파고 0m"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var windLabel: UILabel = {
        var label = UILabel()
        
        label.text = "풍속 남남동풍 1m/s"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var waveHeightLabel2: UILabel = {
        var label = UILabel()
        
        label.text = "파고 0m"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var windLabel2: UILabel = {
        var label = UILabel()
        
        label.text = "풍속 남남동풍 1m/s"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        
        contentView.addSubview(containerView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(tempLabel)
        containerView.addSubview(waveHeightLabel)
        containerView.addSubview(windLabel)
        containerView.addSubview(waveHeightLabel2)
        containerView.addSubview(windLabel2)

        
        containerView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        tempLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(timeLabel.snp.trailing).offset(24)
        }
        
        waveHeightLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tempLabel.snp.trailing).offset(24)
        }
        
        windLabel.snp.makeConstraints{ make in
            make.top.equalTo(waveHeightLabel.snp.bottom)
            make.leading.equalTo(tempLabel.snp.trailing).offset(24)
        }
        
        waveHeightLabel2.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        windLabel2.snp.makeConstraints{ make in
            make.top.equalTo(waveHeightLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-24)
        }
        

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct WeatherViewTableViewCellPreView: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = WeatherViewTableViewCell()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
