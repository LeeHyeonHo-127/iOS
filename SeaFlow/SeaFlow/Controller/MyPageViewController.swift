//
//  MyPageViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/25.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    var myPaveView = MyPageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myPaveView)
        
        myPaveView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
