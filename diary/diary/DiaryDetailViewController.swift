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
    
    //수정 버튼 함수
    @IBAction func editButton(_ sender: UIButton) {
        guard let writeDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let diary = self.diary else { return }
        guard let indexPath = self.indexPath else { return }
        writeDiaryViewController.diaryEditMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil)
        navigationController?.pushViewController(writeDiaryViewController, animated: true)
    }
    
    //삭제 버튼 함수
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.DiaryDelete(indexPath: self.indexPath!)
        self.navigationController?.popViewController(animated: true)
    }
    
    //view를 구성하는 함수
    private func configureView(){
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
    }
    
    //date->String 함수
    func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.string(from: date)
    }
    
    //수정시 view를 재구성하는 함수
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diary = diary
        self.indexPath?.row = row
        configureView()
    }
}
