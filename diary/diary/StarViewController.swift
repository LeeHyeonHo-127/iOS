import UIKit

class StarViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    var diaries: [Diary] = [Diary]()
    
    override func viewDidLoad() {
       
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_ :)),
            name: NSNotification.Name(rawValue: "editDiary"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_: )),
            name: Notification.Name(rawValue: "starDiary"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_: )),
            name: Notification.Name(rawValue: "deleteDiary"),
            object: nil)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDiary()
        configureCollectionView()
    }
    
    //userDefaults에서 diaries를 불러온다
    func loadDiary(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaries") as? [[String:Any]] else {return}
        diaries = data.compactMap({
            guard let uuidString = $0["uuidString"] as? String else {return nil}
            guard let title = $0["title"] as? String else {return nil}
            guard let contents = $0["contents"] as? String else {return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStar = $0["isStar"] as? Bool else {return nil}
            let diary = Diary(uuidString: uuidString, title: title, contents: contents, date: date, isStar: isStar)
            return diary
        })
        self.diaries = diaries.filter{
            $0.isStar == true
        }.sorted{
            $0.date.compare($1.date) == .orderedDescending
        }
        print(diaries)
        
    }
    
    //date->String 함수
    func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.string(from: date)
    }
    
    //collectionView 구성 함수
    func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //diary수정시 수정값 받아오는 함수
    @objc func editDiaryNotification(_ notification: Notification){
        guard let editData = notification.object as? [String: Any] else {return}
        guard let diary = editData["diary"] as? Diary else {return}
        guard let uuidString = editData["uuidString"] as? String else {return}
        guard let index = self.diaries.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaries[index] = diary
        self.collectionView.reloadData()
        self.configureCollectionView()
    }
    
    //diary삭제시 수정값 받아오는 함수
    @objc func deleteDiaryNotification(_ notification: Notification){
        guard let deleteData = notification.object as? [String : Any] else {return}
        guard let uuidString = deleteData["uuidString"] as? String else {return}
        guard let index = self.diaries.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaries.remove(at: index)
        self.collectionView.reloadData()
        self.configureCollectionView()
    }
    
    //diary의 isStar값이 변경 되었을 때 수정 값 받아오는 함수
    @objc func starDiaryNotification(_ notification: Notification){
        guard let starData = notification.object as? [String: Any] else {return}
        guard let isStar = starData["isStar"] as? Bool else {return}
        guard let uuidString = starData["uuidString"] as? String else {return}
        guard let index = self.diaries.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaries[index].isStar = isStar
    }
    
}

//CollectionView 화면 구성
extension StarViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.diaries.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as? StarCell else {return UICollectionViewCell()}
        let diary = self.diaries[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = dateToString(date: diary.date)
        return cell
    }
}
extension StarViewController: UICollectionViewDelegateFlowLayout{
    //콜렉션 뷰 사이즈 반환 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) - 20 , height: 100)
    }
}

extension StarViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else {return}
        viewController.diary = diaries[indexPath.row]
        viewController.indexPath = indexPath
        viewController.uuidString = self.diaries[indexPath.row].uuidString
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
