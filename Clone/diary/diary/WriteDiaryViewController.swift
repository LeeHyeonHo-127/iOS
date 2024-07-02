//
//  WriteDiaryViewController.swift
//  diary
//
//  Created by 이현호 on 2023/01/26.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject{
    func didSelectReigster(diary:Diary)
}

class WriteDiaryViewController: UIViewController {
    
    enum DiaryEditorMode{
        case new
        case edit(String, Diary)
    }

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var confirmButton: UIBarButtonItem!
    
    
    var datePicker = UIDatePicker()
    var diaryDate:Date?
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode: DiaryEditorMode = .new
    
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
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
      guard let title = self.titleTextField.text else { return }
      guard let contents = self.contentsTextView.text else { return }
      guard let date = self.diaryDate else { return }

      switch self.diaryEditorMode {
      case .new:
          let diary = Diary(
            uuidString: UUID().uuidString,
            title: title,
            contents: contents,
            date: date,
            isStar: false)
        self.delegate?.didSelectReigster(diary: diary)

      case let .edit(uuidString ,diary):
          let diary = Diary(
            uuidString: uuidString,
            title: title,
            contents: contents,
            date: date,
            isStar: diary.isStar)
        NotificationCenter.default.post(
          name: NSNotification.Name("editDiary"),
          object: [
            "diary": diary,
            "uuidString": uuidString
          ],
          userInfo: nil
        )
      }
      self.navigationController?.popViewController(animated: true)
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
        switch self.diaryEditorMode{
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
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
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: diaryDate!)
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
