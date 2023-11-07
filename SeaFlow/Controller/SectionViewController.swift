//
//  SectionViewController.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/11/06.
//

import UIKit
import SnapKit
class SectionViewController: UIViewController {

    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "sectionDummy")
        return imageView
    }()
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.text = "DUMMY"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . white
        applyViewCode()
    }
}
extension SectionViewController: ViewCodeProtocol{
    func buildViewHierachy() {
        view.addSubview(imageView)
        view.addSubview(label)
    }
    
    func setUpConstraint() {
        imageView.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(200)
        }
        
        label.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SectionViewPreview: PreviewProvider {
    static var previews: some View {
        SectionViewController().showPreView(.iPhone12Pro)
    }
}
#endif
