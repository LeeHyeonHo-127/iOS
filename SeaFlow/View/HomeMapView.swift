//
//  HomeMapView.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/27.
//

import UIKit
import SnapKit
import MapKit

class HomeMapView: UIView{
    var mkMapView: MKMapView = MKMapView()
    lazy var dateLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeMapView: ViewCodeProtocol{
    func buildViewHierachy() {
        addSubview(mkMapView)
        addSubview(dateLabel)
    }
    
    func setUpConstraint() {
        mkMapView.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
    }
    
    func configureView() {
        dateLabel.text = "2023-01-01 10:00"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct HomeMapViewCellPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = HomeMapView()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
