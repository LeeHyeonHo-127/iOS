//
//  DiaryDetailViewController.swift
//  diary
//
//  Created by 이현호 on 2023/01/26.
//

import UIKit

protocol DiaryDetailDelegate: AnyObject{
    func DiaryDelete(indexPath: IndexPath)
}

class DiaryDetailViewController: UIViewController {
    

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    
    var diary: Diary?
    var indexPath: IndexPath?
    var delegate: DiaryDetailDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func editButton(_ sender: UIButton) {
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.DiaryDelete(indexPath: self.indexPath!)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    private func configureView(){
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
    }
    
    func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.string(from: date)
    }
}
