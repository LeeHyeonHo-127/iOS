//
//  DiaryViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class DiaryViewController: UIViewController {

    var topView = DiaryTopView()
    var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topView)
        
        tableViewSetup()
        
        topView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        

        // Do any additional setup after loading the view.
    }
    func tableViewSetup(){
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: "DiaryTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 110
        
        topView.snp.makeConstraints{make in
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(160)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
extension DiaryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell", for: indexPath) as! DiaryTableViewCell
       
        
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DiaryViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DiaryViewController().showPreView(.iPhone12Pro)
    }
}
#endif
