//
//  MainViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
        
        let MainCollectionViewController = MainCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

                
        // HomeViewController를 자식 뷰 컨트롤러로 추가
        addChild(MainCollectionViewController)
        MainCollectionViewController.view.frame = collectionView.bounds
        collectionView.addSubview(MainCollectionViewController.view)
        MainCollectionViewController.didMove(toParent: self)

    }
    
    @IBAction func koreanFinanceButton(_ sender: Any) {
        let websiteURL = URL(string: "https://www.hankyung.com/")
        if let url = websiteURL {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
    }
    @IBAction func everydayFinanceButton(_ sender: Any) {
        let websiteURL = URL(string: "https://www.mk.co.kr/")
        if let url = websiteURL {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
        
    }
    @IBAction func searchButton(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "StockDetailViewController") as? StockDetailViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func hideKeyboard() {
           view.endEditing(true)
       }
}

extension MainViewController: UITextFieldDelegate{
    // UITextFieldDelegate 메서드로 텍스트 필드에서 리턴 키를 눌렀을 때 키패드를 사라지게 할 수도 있습니다.
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
