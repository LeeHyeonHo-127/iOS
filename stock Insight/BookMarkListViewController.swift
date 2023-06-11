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
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getBookmarkStockList()
        
        // UIRefreshControl 설정
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func refreshData() {
        refreshControl.endRefreshing()
        }
    
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookMarkStockList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCollectionViewCell", for: indexPath) as? StarCollectionViewCell else {return UICollectionViewCell()}
        cell.imageView.image = self.bookMarkStockList[indexPath.row].stockImage
        cell.stockNameLabel.text = self.bookMarkStockList[indexPath.row].stockName
        cell.stockNumberLabel.text = self.bookMarkStockList[indexPath.row].stockNumber
        return cell
    }
}

extension BookMarkListViewController: UICollectionViewDelegate{
    
}

extension BookMarkListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) - 20, height: 60)
    }
}
