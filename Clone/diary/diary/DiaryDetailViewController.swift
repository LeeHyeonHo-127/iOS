//
//  DiaryDetailViewController.swift
//  diary
//
//  Created by 이현호 on 2023/01/26.
//

import UIKit

//protocol DiaryDetailDelegate: AnyObject{
//    func DiaryDelete(indexPath: IndexPath)
//    func didSelectStar(indexPath: IndexPath)
//}

class DiaryDetailViewController: UIViewController {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    
    var diary: Diary?
    var uuidString: String?
    var indexPath: IndexPath?
//    var delegate: DiaryDetailDelegate?
    var StarButton: UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_: )),
            name: Notification.Name(rawValue: "starDiary"),
            object: nil)
        configureView()
    }
    
    //수정 버튼 함수
    @IBAction func editButton(_ sender: UIButton) {
        guard let writeDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let diary = self.diary else { return }
        guard let uuidString = self.uuidString else { return }
        writeDiaryViewController.diaryEditorMode = .edit(uuidString, diary)//.edit(indexPath, diary)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil)
        navigationController?.pushViewController(writeDiaryViewController, animated: true)
    }
    
    //삭제 버튼 함수
    @IBAction func deleteButton(_ sender: UIButton) {
        //delegate?.DiaryDelete(indexPath: self.indexPath!)
        NotificationCenter.default.post(name: NSNotification.Name("deleteDiary"),
                                        object: [
                                            "uuidString" : self.uuidString,
                                            "indexPath" : self.indexPath
                                        ],
                                        userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    //view를 구성하는 함수
    private func configureView(){
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
        self.StarButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(isTapStarButton))
        self.StarButton?.tintColor = .orange
        self.StarButton!.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.navigationItem.rightBarButtonItem = StarButton
    }
    
    //date->String 함수
    func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.string(from: date)
    }
    
    //수정시 view를 재구성하는 함수
    @objc func editDiaryNotification(_ notification: Notification){
        guard let editDiaryData = notification.object as? [String : Any] else { return }
        guard let diary = editDiaryData["diary"] as? Diary else {return}
        guard let uuidString = editDiaryData["uuidString"] as? String else {return}
        if self.diary?.uuidString == uuidString{
            self.diary = diary
        }
        self.configureView()
    }
    
    @objc func starDiaryNotification(_ notification: Notification){
      
        guard let starData = notification.object as? [String : Any] else {return}
        guard let isStar = starData["isStar"] as? Bool else {return}
        guard let uuidString = starData["uuidString"] as? String else {return}
        if self.uuidString == uuidString && self.diary?.isStar != isStar{
            self.diary?.isStar = isStar
            self.configureView()
        }
        
    }
    
    //starButton이 눌렸을 때의 동작
    @objc func isTapStarButton(){
        guard let diary = self.diary else {return}
        guard let uuidString = self.uuidString else {return}
        if diary.isStar{
            self.StarButton?.image = UIImage(systemName: "star")
        }else{
            self.StarButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !diary.isStar
        //delegate?.didSelectStar(indexPath: indexPath)
        NotificationCenter.default.post(name: NSNotification.Name("starDiary"),
                                        object: [
                                            "isStar": self.diary?.isStar ?? false,
                                            "uuidString": uuidString
                                        ],
                                        userInfo: nil)
    }
}
