//
//  HomeViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//


import UIKit
import SnapKit
import MapKit

class HomeViewController: UIViewController {
    var topView = HomeTopView()
    var mapView = HomeMapView()
    var beforeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        beforeButton = topView.setTideMapButton
    }
        
}

extension HomeViewController: ViewCodeProtocol{
    func buildViewHierachy() {
        view.addSubview(topView)
        view.addSubview(mapView)
    }
    
    func setUpConstraint() {
        topView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(160)
            
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.leading.equalToSuperview()
        }
        
        mapView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            
            make.top.equalTo(topView.splitView.snp.bottom)
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        topView.delegate = self
        view.backgroundColor = .white
    }
    
    /*
    @objc func setMapButtonTapped(_ sender: UIButton){
        var buttonNum = 0
        
        beforeButton.setTitleColor(.black, for: .normal)
        sender.setTitleColor(UIColor(named: "SeaFlowBlue"), for: .normal)
        beforeButton = sender
        
        
        switch sender {
        case topView.setTideMapButton :
            buttonNum = 0
        case topView.setWaterTempMapButton :
            buttonNum = 1
        case topView.setDepthOfWaterMapButton :
            buttonNum = 2
        case topView.setSaltMapButton :
            buttonNum = 3
        case topView.setFlowRateMapButton :
            buttonNum = 4
        default :
            buttonNum = 1
        }
        
        
        topView.showSelectButtonView.removeFromSuperview()
        topView.splitView.addSubview(showSelectButtonView)
        
        showSelectButtonView.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.height.equalTo(1)
            
            make.top.equalTo(topView.splitView.snp.top)
            make.leading.equalTo(Int(UIScreen.main.bounds.width) / 5 * buttonNum)
        }
    }*/
}

extension HomeViewController: SetMapButtonDelegate {
    func setMapButtontapped(tappedButton: UIButton, beforeButton: UIButton, selectedView: UIView) {
        
        
        tappedButton.setTitleColor(UIColor.seaFlowBlue, for: .normal)
        beforeButton.setTitleColor(UIColor.black, for: .normal)
        
        selectedView.snp.remakeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.height.equalTo(1)
            
            make.top.equalToSuperview()
            make.leading.equalTo(tappedButton.snp.leading)
        }

    }
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct VCPreview: PreviewProvider {
    static var previews: some View {
        HomeViewController().showPreView(.iPhone12Pro)
    }
}
#endif
