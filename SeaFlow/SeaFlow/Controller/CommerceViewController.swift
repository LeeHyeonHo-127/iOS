//
//  DiaryViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class CommerceViewController: UIViewController {

    var topView = CommerceTopView()
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
        tableView.rowHeight = 100
        tableView.register(CommerceTableViewCell.self, forCellReuseIdentifier: "CommerceTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        
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
extension CommerceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommerceTableViewCell", for: indexPath) as! CommerceTableViewCell
       
        
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CommerceViewControllerPreView: PreviewProvider {
    static var previews: some View {
        CommerceViewController().showPreView(.iPhone12Pro)
    }
}
#endif
