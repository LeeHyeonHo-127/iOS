//
//  BookMarkListViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit

struct BookMarkStock{
    var stockName: String
    var stockNumber: String
    var stockImage: UIImage
}

class BookMarkListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var bookMarkStockList: [BookMarkStock] = []
    let refreshControl = UIRefreshControl()
    
  
    //viweDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getBookmarkStockList()
    }
    
    //viewWillAppead
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    

    //MARK: - 설정 함수
    
    //collection layout 및 기본 설정 함수
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        refreshControl.endRefreshing()
    }
    
    //MARK: - 데이터 관련 함수
    

    
    //즐겨찾기에 넣을 더미 데이터 생성 함수
    private func getBookmarkStockList(){
        let stockName1 = "삼성전자"
        let stockNumber1 = "A005930 코스피"
        let stockImage1:UIImage = UIImage(imageLiteralResourceName: "samsung_Icon")
        let bookmarkStock1 = BookMarkStock(stockName: stockName1, stockNumber: stockNumber1, stockImage: stockImage1)
        self.bookMarkStockList.append(bookmarkStock1)
        let stockName2 = "애플"
        let stockNumber2 = "US.PEGY 나스닥"
        let stockImage2: UIImage = UIImage(imageLiteralResourceName: "apple_Icon")
        let bookmarkStock2 = BookMarkStock(stockName: stockName2, stockNumber: stockNumber2, stockImage: stockImage2)
        self.bookMarkStockList.append(bookmarkStock2)
        let stockName3 = "마이크로소프트"
        let stockNumber3 = "US.MSFT 나스닥"
        let stockImage3: UIImage = UIImage(imageLiteralResourceName: "ms_Icon")
        let bookmarkStock3 = BookMarkStock(stockName: stockName3, stockNumber: stockNumber3, stockImage: stockImage3)
        self.bookMarkStockList.append(bookmarkStock3)
        let stockName4 = "현대차"
        let stockNumber4 = "A005380 코스피"
        let stockImage4: UIImage = UIImage(imageLiteralResourceName: "hyundai_Icon")
        let bookmarkStock4 = BookMarkStock(stockName: stockName4, stockNumber: stockNumber4, stockImage: stockImage4)
        self.bookMarkStockList.append(bookmarkStock4)
    }
}


extension BookMarkListViewController: UICollectionViewDataSource{
    //collectionView item 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookMarkStockList.count
    }
    
    //cell 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCollectionViewCell", for: indexPath) as? StarCollectionViewCell else {return UICollectionViewCell()}
        cell.settingCell()
        return cell
    }
}

extension BookMarkListViewController: UICollectionViewDelegate{
}


extension BookMarkListViewController: UICollectionViewDelegateFlowLayout{
    //collectionView 레이아웃 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) , height: 50)
    }
}
