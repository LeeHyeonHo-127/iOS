import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionVIew: UICollectionView!
    
    //일기 배열
    var diaries:[Diary] = [Diary](){
        didSet{
            saveDiary()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadDiary()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_: )),
            name: NSNotification.Name(rawValue: "editDiary"),
            object: nil)
    }
    
   //perpare 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
            writeDiaryViewController.delegate = self
        }
    }
    
    //collectionView를 구성하는 함수
    func configureCollectionView(){
        self.collectionVIew.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionVIew.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionVIew.delegate = self
        self.collectionVIew.dataSource = self
    }
    
    //date->String 함수
    func dateToString(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter.string(from: date)
    }
    
    //userDefaults를 활용해 diary값들을 저장하는 함수
    func saveDiary(){
        let userDefaults = UserDefaults.standard
        let diaries = self.diaries.map{[
            "title" : $0.title,
            "contents" : $0.contents,
            "date" : $0.date,
            "isStar" : $0.isStar
        ]}
        userDefaults.set(diaries, forKey: "diaries")
    }
    
    //userDefaults를 활용해 diary값들을 불러오는 함수
    func loadDiary(){
        let userDefaults = UserDefaults.standard
        guard let diaries = userDefaults.object(forKey: "diaries") as? [[String: Any?]] else{return}
        self.diaries = diaries.compactMap{
            guard let title = $0["title"] as? String else {return nil}
            guard let contents = $0["contents"] as? String else {return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStar = $0["isStar"] as? Bool else {return nil}
            let diary = Diary(title: title, contents: contents, date: date, isStar: isStar)
            return diary
        }
        self.diaries = self.diaries.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    //일기가 수정됐을떄, 수정된 값으로 화면을 재수성하는 함수
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else {return}
        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diaries[row] = diary
        self.diaries = self.diaries.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionVIew.reloadData()
    }
    
}


//CollectionView 화면 구성
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaries.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionVIew.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else {return UICollectionViewCell()}
        let diary = self.diaries[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = dateToString(date: diary.date)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    //cell이 클릭 됐을 때 [일기 상세 화면]으로 이동하는 함수
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        let diary = self.diaries[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    //콜렉션 뷰 사이즈 반환 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - 20 , height: 200)
    }
}

extension ViewController: DiaryDetailDelegate{
    //diary 삭제 함수
    func DiaryDelete(indexPath: IndexPath) {
        self.diaries.remove(at: indexPath.row)
        self.collectionVIew.deleteItems(at: [indexPath])
        self.collectionVIew.reloadData()
    }
}

extension ViewController: WriteDiaryViewDelegate{
    //diary 등록 함수
    func didSelectResister(diary: Diary) {
        self.diaries.append(diary)
        self.diaries = self.diaries.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionVIew.reloadData()
    }
}



