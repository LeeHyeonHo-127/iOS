//
//  ViewController.swift
//  haeIn_photoes
//
//  Created by 이현호 on 2023/02/24.
//

import UIKit

class ViewController: UIViewController {
    enum Mode{
        case editMode
        case normalMode
    }
    
    @IBOutlet var collectionView: UICollectionView!
    var folders:[Folder] = [Folder]()
   
    let button = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
    @objc func nextTapped(){
        performSegue(withIdentifier: "photoViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextViewController" {
            // 대상 뷰 컨트롤러에서 필요한 초기화 작업을 수행합니다.
        }
    }
//    var mode:Mode!
    
//  scroll을 통한 데이터 최신화 -> 아직 구현 안됨
//    private lazy var refresh: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//
//        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
//        return refreshControl
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = button
//        self.configureCollectionView()
//        for index in 1...15 {
//            let dump = Folder(folderName: "\(index)")
//            self.folders.append(dump)
//        }
//        self.collectionView.isScrollEnabled = true
//        self.collectionView.allowsSelection = true
//        mode = .normalMode
    }
    
   
    
//    @objc func refreshAction(){
//        self.collectionView.reloadData()
//    }
    
    
    //폴더 추가 버튼
    @IBAction func tapPlusBarButton(_ sender: Any) {
        let alert = UIAlertController(title: "폴더 이름을 입력해 주세요", message: nil, preferredStyle: .alert)
        let resisterButton = UIAlertAction(title: "추가", style: .default, handler: {[weak self] _ in
            guard let textfield = alert.textFields?[0].text else {return}
            let folder = Folder(folderName: textfield)
            self?.folders.append(folder)
            self?.collectionView.reloadData()
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(resisterButton)
        alert.addAction(cancelButton)
        alert.addTextField { textField in
            textField.placeholder = "폴더 이름"
        }
        self.present(alert, animated: true)
    }
    
    //편집 모드 버튼
//    @IBAction func tapEditBarButton(_ sender: Any) {
//        self.collectionView.allowsSelection = false
//        self.setEditing(true, animated: true)
//        self.collectionView.isEditing = true
//        self.mode = .editMode
//        self.isEditing = true
//    }
    
    
    //CollectionView setting 함수
    func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
    

extension ViewController: UICollectionViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.collectionView.refreshControl = refresh
//    }
    
//    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
//        true
//    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        if self.mode == .editMode{
//            return false
//        }else { return true }
//    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath) as? FolderCell else {return UICollectionViewCell()}
        
        let folder = self.folders[indexPath.row]
        cell.folderName.text = folder.folderName
        cell.forlderImage.image = UIImage.checkmark
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        //
//    }
//
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - 20 , height: 200)
    }
}
