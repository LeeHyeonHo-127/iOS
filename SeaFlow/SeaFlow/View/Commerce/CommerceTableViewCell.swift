//
//  TableViewCell.swift
//  Danggeun
//
//  Created by 이현호 on 2023/10/11.
//

import UIKit
import SnapKit

class CommerceTableViewCell: UITableViewCell {
    
    lazy var diaryDummyImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "commerceDummy")
        return imageView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        
        addSubview(diaryDummyImage)

        
        diaryDummyImage.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct CommerceTableViewCellPreView: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = DiaryTableViewCell()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
