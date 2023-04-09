//
//  DiaryDetailViewController.swift
//  diary_fc
//
//  Created by 이현호 on 2023/03/20.
//

import UIKit

class DiaryDetailViewController: UIViewController {

    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    var diary:Diary?
    var indexPath: IndexPath?
    var starButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_: )),
            name: NSNotification.Name("starDiary"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_: )),
            name: NSNotification.Name("editDiary"),
            object: nil)
    }
    
    @objc func starDiaryNotification(_ notification : Notification){
        guard let starDiary = notification.object as? [String: Any] else {return}
        guard let isStar = starDiary["isStar"] as? Bool else {return}
        guard let uuidString = starDiary["uuidString"] as? String else {return}
        guard let diary = self.diary else {return}
        if diary.uuidString == uuidString{
            self.diary?.isStar = isStar
            self.configureView()
        }
    }
    
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else {return}
        self.diary = diary
        self.configureView()
    }

    @IBAction func tapEditButton(_ sender: Any) {
        guard let writeDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        writeDiaryViewController.diaryEditorMode = .edit(indexPath, diary)
        self.navigationController?.pushViewController(writeDiaryViewController, animated: true)
    }
   
    
    @IBAction func tapDeleteButton(_ sender: Any) {
        guard let uuidString = self.diary?.uuidString else {return}
        NotificationCenter.default.post(name: NSNotification.Name("deleteDiary"),
                                        object: uuidString,
                                        userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func configureView(){
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dataLabel.text = self.dateToString(date: diary.date)
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = starButton
    }
    
    @objc func tapStarButton(){
        guard let isStar = self.diary?.isStar else {return}
        guard let uuidString = self.diary?.uuidString else {return}
        if isStar{
            self.starButton?.image = UIImage(systemName: "star")
        }else{
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        
        NotificationCenter.default.post(
            name: Notification.Name("starDiary"),
            object:[
                "uuidString" : self.diary?.uuidString,
                "diary" : self.diary,
                "isStar" : self.diary?.isStar ?? false
            ],
            userInfo: nil
        )
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
