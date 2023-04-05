//
//  DiaryDetailViewController.swift
//  diary_fc
//
//  Created by 이현호 on 2023/03/20.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject{
    func didSelectDelete(indexPath: IndexPath)
    func didSelectStar(indexPath: IndexPath, isStar: Bool)
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    var diary:Diary?
    var indexPath: IndexPath?
    weak var delegate: DiaryDetailViewDelegate?
    var starButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    @IBAction func tapEditButton(_ sender: Any) {
        guard let writeDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        writeDiaryViewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_: )), name: NSNotification.Name("editDiary"), object: nil)
        self.navigationController?.pushViewController(writeDiaryViewController, animated: true)
    }
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else {return}
        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diary = diary
        self.configureView()
    }
    
    @IBAction func tapDeleteButton(_ sender: Any) {
        guard let indexPath = self.indexPath else {return}
        delegate?.didSelectDelete(indexPath: indexPath)
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
        guard let indexPath = self.indexPath else {return}
        if isStar{
            self.starButton?.image = UIImage(systemName: "star")
        }else{
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        self.delegate?.didSelectStar(indexPath: indexPath, isStar: self.diary?.isStar ?? false)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
