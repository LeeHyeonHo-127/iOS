//
//  ShowWeatherViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class ShowWeatherViewController: UIViewController {
    
    var topView = ShowWeatherTopView()
    var weatherView1 = WeatherView()
    var weatherView2: WeatherView = {
        var weatherview = WeatherView()
        weatherview.tempLabel.text = "6몰"
        weatherview.highestAndLowestTempLabel.text = "일출"
        weatherview.waveHeightLabel.text = "일몰"
        weatherview.windSpeendLabel.text = "현재 예측조위 716cm"
        return weatherview
    }()
    var tableView: UITableView!
    
    lazy var splitView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(topView)
        view.addSubview(weatherView1)
        view.addSubview(weatherView2)
        view.addSubview(splitView)
        
        
        setUI()
        tableViewSetup()
//        view.addSubview(weatherView2)

    }
    
    func tableViewSetup(){
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.register(WeatherViewTableViewCell.self, forCellReuseIdentifier: "WeatherViewTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(weatherView1.snp.bottom).offset(24)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setUI(){
        topView.snp.makeConstraints{ make in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
            
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        weatherView1.snp.makeConstraints{ make in
            make.height.equalTo(46)
            make.width.equalTo(181)
            
            make.leading.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(16)
        }
        
        weatherView2.snp.makeConstraints{ make in
            make.height.equalTo(46)
            make.width.equalTo(181)
            
            make.trailing.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(16)
        }
        
        splitView.snp.makeConstraints{ make in
            make.height.equalTo(46)
            make.width.equalTo(1)
            
            make.leading.equalTo(weatherView2.snp.leading)
            make.top.equalTo(topView.snp.bottom).offset(16)
        }
        
//
//        weatherView2.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(170)
//        }
    }
}


extension ShowWeatherViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherViewTableViewCell", for: indexPath)
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ShowWeatherViewPreview: PreviewProvider {
    static var previews: some View {
        ShowWeatherViewController().showPreView(.iPhone15Pro)
    }
}
#endif
