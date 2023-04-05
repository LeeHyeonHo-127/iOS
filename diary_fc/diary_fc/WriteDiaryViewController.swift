//
//  WriteDiaryViewController.swift
//  diary_fc
//
//  Created by 이현호 on 2023/03/20.
//

import UIKit

enum DiaryEditorMode{
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectResister(diary: Diary)
}


class WriteDiaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputTextField()
        self.confirmButton.isEnabled = false
        self.configureEditMode()
        
    }

    @IBOutlet var confirmButton: UIBarButtonItem!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode: DiaryEditorMode = .new
    
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentTextView.text else {return}
        guard let date = self.diaryDate else {return}
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        
        switch self.diaryEditorMode{
        case .new:
            self.delegate?.didSelectResister(diary: diary)
        case let .edit(indexPath, _):
            NotificationCenter.default.post(name: Notification.Name("editDiary"), object: diary, userInfo: ["indexPath.row" : indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func configureContentsTextView(){
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentTextView.layer.borderColor = borderColor.cgColor
        self.contentTextView.layer.borderWidth = 0.5
        self.contentTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)

    }
    
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentTextView.text.isEmpty
        
//        print("titleTextField 는 비어있지 않습니다. : " ,!(self.titleTextField.text?.isEmpty ?? true))
//        print("dateTextField 는 비어있지 않습니다. : " ,!(self.dateTextField.text?.isEmpty ?? true))
//        print("contentTextField 는 비어있지 않습니다.: " ,!self.contentTextView.text.isEmpty)
    }
    
    private func configureInputTextField(){
        self.contentTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector (titleTextFieldDidChange(_: )), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector (dateTextFieldDidChange(_: )), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    private func configureEditMode(){
        switch self.diaryEditorMode {
        case let.edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default:
            break
        }
    }
    private func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension WriteDiaryViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
