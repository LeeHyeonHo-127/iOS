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
        NotificationCenter.default.addObserver( //수정된 일기 값 받아오기
            self,
            selector: #selector(editDiaryNotification(_: )),
            name: NSNotification.Name(rawValue: "editDiary"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_: )),
            name: Notification.Name(rawValue: "deleteDiary"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_: )),
            name: NSNotification.Name(rawValue: "starDiary"),
            object: nil)
    }
    
   //prepare 함수
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
            "uuidString" : $0.uuidString,
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
            guard let uuidString = $0["uuidString"] as? String else {return nil}
            guard let title = $0["title"] as? String else {return nil}
            guard let contents = $0["contents"] as? String else {return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStar = $0["isStar"] as? Bool else {return nil}
            let diary = Diary(uuidString: uuidString, title: title, contents: contents, date: date, isStar: isStar)
            return diary
        }
        self.diaries = self.diaries.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    //일기가 수정됐을떄, 수정된 값으로 화면을 재수성하는 함수
    @objc func editDiaryNotification(_ notification: Notification){
        guard let editData = notification.object as? [String: Any] else {return}
        guard let diary = editData["diary"] as? Diary else {return}
        guard let uuidString = editData["uuidString"] as? String else {return}
        guard let index = self.diaries.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaries[index] = diary
        self.diaries = self.diaries.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionVIew.reloadData()
        self.configureCollectionView()
    }
    
    //isStar값을 받아 diaries의 isStar값을 변경하는 함수
    @objc func starDiaryNotification(_ notification: Notification){
        guard let starDiary = notification.object as? [String: Any] else {return}
        guard let isStar = starDiary["isStar"] as? Bool else {return}
        guard let uuidString = starDiary["uuidString"] as? String else {return}
        guard let index = self.diaries.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaries[index].isStar = isStar
    }
    
    //삭제된 데이터를 받아 삭제하는 함수
    @objc func deleteDiaryNotification(_ notification: Notification){
        guard let deleteData = notification.object as? [String : Any] else {return}
        guard let uuidString = deleteData["uuidString"] as? String else {return}
        guard let indexPath = deleteData["indexPath"] as? IndexPath else {return}
        guard let index = self.diaries.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.diaries.remove(at: index)
        self.collectionVIew.deleteItems(at: [indexPath])
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
        viewController.uuidString = self.diaries[indexPath.row].uuidString
        viewController.indexPath = indexPath
//        viewController.delegate = self
        saveDiary()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    //콜렉션 뷰 사이즈 반환 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2) - 20 , height: 200)
    }
}

//extension ViewController: DiaryDetailDelegate{
//    //diary 삭제 함수
//    func DiaryDelete(indexPath: IndexPath) {
//        self.diaries.remove(at: indexPath.row)
//        self.collectionVIew.deleteItems(at: [indexPath])
//        self.collectionVIew.reloadData()
//    }
//
//    func didSelectStar(indexPath: IndexPath) {
//        self.diaries[indexPath.row].isStar = !self.diaries[indexPath.row].isStar
//    }
//}

extension ViewController: WriteDiaryViewDelegate{
    //diary 등록 함수
    func didSelectReigster(diary: Diary) {
        self.diaries.append(diary)
        self.diaries = self.diaries.sorted(by: { 
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionVIew.reloadData()
    }
}



