//
//  HomeViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//


import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var topView = HomeTopView()
    
    
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
    
    lazy var setTideMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("조석", for: .normal)
        button.setTitleColor(UIColor(named: "SeaFlowBlue"), for: .normal)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.white
        return button
    }()
    
    lazy var setWaterTempMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("수온", for: .normal)
        button.setTitleColor(.black, for: .normal)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.white
        return button
    }()
    
    lazy var setDepthOfWaterMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("수심", for: .normal)
        button.setTitleColor(.black, for: .normal)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.white
        return button
    }()
    
    lazy var setSaltMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("염분", for: .normal)
        button.setTitleColor(.black, for: .normal)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.white
        return button
    }()
    
    lazy var setFlowRateMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("유속", for: .normal)
        button.setTitleColor(.black, for: .normal)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.white
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var splitView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var showSelectButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SeaFlowBlue")
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023-01-01 10:00"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    func setUI(){
        view.addSubview(topView)
        view.addSubview(sectionButton)
        view.addSubview(buttonStackView)
        view.addSubview(setTideMapButton)
        view.addSubview(setWaterTempMapButton)
        view.addSubview(setDepthOfWaterMapButton)
        view.addSubview(setSaltMapButton)
        view.addSubview(setFlowRateMapButton)
        view.addSubview(splitView)
        view.addSubview(showSelectButtonView)
        view.addSubview(dateLabel)
        
        
        //topView Constraint
        topView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        
        //sectionButton
        sectionButton.snp.makeConstraints{ make in
            make.height.equalTo(25)
            make.width.equalTo(41)
            
            make.trailing.equalTo(topView.snp.trailing).offset(-24)
            make.top.equalTo(topView.dateLabel1).offset(5)
        }
        
        setTideMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)
                               
            make.top.equalTo(topView.locationLabel.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        setWaterTempMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalTo(topView.locationLabel.snp.bottom).offset(16)
            make.leading.equalTo(setTideMapButton.snp.trailing)
        }
        
        setDepthOfWaterMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalTo(topView.locationLabel.snp.bottom).offset(16)
            make.leading.equalTo(setWaterTempMapButton.snp.trailing)
        }
        
        setSaltMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalTo(topView.locationLabel.snp.bottom).offset(16)
            make.leading.equalTo(setDepthOfWaterMapButton.snp.trailing)
        }
        
        setFlowRateMapButton.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 5)

            make.top.equalTo(topView.locationLabel.snp.bottom).offset(16)
            make.leading.equalTo(setSaltMapButton.snp.trailing)
        }
        
        splitView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(1)

            make.top.equalTo(setFlowRateMapButton.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        showSelectButtonView.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.height.equalTo(1)
            
            make.top.equalTo(splitView.snp.top)
            make.leading.equalTo(setTideMapButton)
            
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(splitView.snp.bottom).offset(12)
        }
        
        sectionButton.addTarget(self, action: #selector(testPrint), for: .touchUpInside)
    }
    
    
    @objc func testPrint(){
        print("hi")
        showSelectButtonView.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.height.equalTo(1)
            
            make.top.equalTo(splitView.snp.top)
            make.leading.equalTo(UIScreen.main.bounds.width / 5 * 2)
        }
        
    }
    
    @objc func waterTempButtonTapped(){
        showSelectButtonView.snp.makeConstraints{ make in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.height.equalTo(1)
            
            make.top.equalTo(splitView.snp.top)
            make.leading.equalTo(UIScreen.main.bounds.width / 5 * 2)
            
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
