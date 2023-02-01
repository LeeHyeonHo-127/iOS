//
//  WriteDiaryViewController.swift
//  diary
//
//  Created by 이현호 on 2023/01/26.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject{
    func didSelectResister(diary:Diary)
}

class WriteDiaryViewController: UIViewController {
    
    enum DiaryEditMode{
        case new
        case edit(IndexPath, Diary)
    }

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var confirmButton: UIBarButtonItem!
    
    
    var datePicker = UIDatePicker()
    var Diarydate:Date?
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditMode: DiaryEditMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmButton.isEnabled = false
        configureContentsTextView()
        configureDatePicker()
        configureInputField()
        configureEditMode()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //등록 버튼
    @IBAction func tapConfirmButton(_ sender: Any) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.Diarydate else {return}
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        
        switch self.diaryEditMode{
        case .new:
            self.delegate?.didSelectResister(diary: diary)
            self.navigationController?.popViewController(animated: true)
        case let .edit(indexPath,_):
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "editDiary"),
                object: diary,
                userInfo: ["indexPath.row" : indexPath.row]
            )
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //contentTextView 사각형 그리기
    func configureContentsTextView(){
        let BorderColor: UIColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = BorderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    //datePicker 설정 함수
    func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_ :)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR")
        self.dateTextField.inputView = self.datePicker
    }
    //조건 충족시 등록 버튼을 활성화하는 함수
    func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text.isEmpty)
    }
    
    //모든 textField 값 변경시 조건을 확인하는 함수
    func configureInputField(){
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextDidChange(_: )), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextDidChange(_ :)), for: .editingChanged)
    }
    
    //date->String 함수
    func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.string(from: date)
    }
    
    //수정 화면일 시 화면을 구성하는 함수
    private func configureEditMode(){
        switch self.diaryEditMode{
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.dateTextField.text = dateToString(date: diary.date)
            self.contentsTextView.text = diary.contents
            self.confirmButton.title = "수정"
        default: break
        }
    }
    
    //datePicker가 바뀌었을 때 textField를 바꿔주는 함수
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.Diarydate = datePicker.date
        self.dateTextField.text = formatter.string(from: Diarydate!)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    //title이 바뀌었을 때 조건을 확안하는 함수
    @objc private func titleTextDidChange(_ titleTextField : UITextField){
        self.validateInputField()
    }
    
    //date가 바뀌었을 때 조건을 확인하는 함수
    @objc private func dateTextDidChange(_ dateTextField: UITextField){
        self.validateInputField()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}


extension WriteDiaryViewController: UITextViewDelegate{
    
    //textView가 값이 변경되었을 때 조건을 확인하는 함수
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
