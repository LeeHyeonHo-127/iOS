import UIKit

class StockDetailViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationItem.title = "종목 상세화면"
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starButtonTapped))
        self.navigationItem.rightBarButtonItem = starButton
        let StockDetailCollectionViewController = StockDetailCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

                
        // HomeViewController를 자식 뷰 컨트롤러로 추가
        addChild(StockDetailCollectionViewController)
        StockDetailCollectionViewController.view.frame = collectionView.bounds
        collectionView.addSubview(StockDetailCollectionViewController.view)
        StockDetailCollectionViewController.didMove(toParent: self)

    }
    @objc func starButtonTapped() {
        if self.navigationItem.rightBarButtonItem?.image == UIImage(systemName: "star") {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            self.navigationItem.rightBarButtonItem?.tintColor = .systemYellow
          } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
              self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue

          }
    }
    

    @IBAction func koreanFinanceButton(_ sender: Any) {
        let websiteURL = URL(string: "https://www.hankyung.com/tag/%EC%82%BC%EC%84%B1%EC%A0%84%EC%9E%90")
        if let url = websiteURL {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
    }
    @IBAction func everyDayFinanceButton(_ sender: Any) {
        let websiteURL = URL(string: "https://stock.mk.co.kr/price/home/KR7005930003")
        if let url = websiteURL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
