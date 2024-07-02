//
//  ShowWeatherViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class ShowWeatherViewController: UIViewController {
    
    var labelString = [["00시", "13°C", "강수확률 30%", "", "습도 65%", "풍속 북서풍 12.6m/s"],
                       ["03시", "12°C", "강수확률 30%", "", "습도 65%", "풍속 북서풍 12.1m/s"],
                       ["06시", "12°C", "강수확률 30%", "", "습도 65%", "풍속 북서풍 9.1m/s"],
                       ["09시", "13°C", "강수확률 30%", "", "습도 65%", "풍속 북서풍 7.7m/s"],
                       ["12시", "14°C", "강수확률 20%", "", "습도 65%", "풍속 북서풍 6.6m/s"],
                       ["15시", "14°C", "강수확률 30%", "", "습도 60%", "풍속 북풍 5.9m/s"],
                       ["18시", "14°C", "강수확률 30%", "", "습도 65%", "풍속 북풍 4.4m/s"],
                       ["20시", "13°C", "강수확률 30%", "", "습도 65%", "풍속 북동풍 3.8m/s"],
                       ["21시", "12°C", "강수확률 30%", "", "습도 65%", "풍속 북동풍 2.9m/s"]
                        ]
    
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
        tableView.rowHeight = 60
        tableView.register(WeatherViewTableViewCell.self, forCellReuseIdentifier: "WeatherViewTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60
        
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
            make.top.equalTo(topView.snp.bottom).offset(18)
        }
        
//
//        weatherView2.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(170)
//        }
    }
}


extension ShowWeatherViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "WeatherViewTableViewCell", for: indexPath) as! WeatherViewTableViewCell
        cell.timeLabel.text = labelString[indexPath.row][0]
        cell.tempLabel.text = labelString[indexPath.row][1]
        cell.waveHeightLabel.text = labelString[indexPath.row][2]
        cell.windLabel.text = labelString[indexPath.row][3]
        cell.waveHeightLabel2.text = labelString[indexPath.row][4]
        cell.windLabel2.text = labelString[indexPath.row][5]
        
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
