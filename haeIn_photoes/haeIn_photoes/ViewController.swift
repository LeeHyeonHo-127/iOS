//
//  ViewController.swift
//  haeIn_photoes
//
//  Created by 이현호 on 2023/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    var folders:[Folder] = [Folder]()
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBAction func tapPlusBarButton(_ sender: Any) {
        print("tapPlusBarButton동작")
        var dump:Folder = Folder(folderName: "dump")
        self.folders.append(dump)
        print(folders)
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate{
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsIbSection return 값 \(self.folders.count)")
        return self.folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt 동작1")
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath) as? FolderCell else {return UICollectionViewCell()}
        print("cellForItemAt 동작 2")
        
        let folder = self.folders[indexPath.row]
        cell.folderName.text = folder.folderName
        cell.forlderImage.image = UIImage(named: "folderImage.png")
        print("cellForItemAt 동작3")
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - 20 , height: 200)
    }
}
