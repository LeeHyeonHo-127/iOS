import UIKit


class HomeViewController: UICollectionViewController{
    
    var contents: [Content] = []
    var mainItem: Item?
    var predictGraphName: [String] = ["시계열분석", "감성 분석", "현재 주가"]
    var presentGrapeName: [String] = ["코스피", "코스닥", "S&P 500"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 가져오기
        contents = self.getContents()
        mainItem = contents.first?.contentItem.randomElement()
        
        //내비게이션 설정
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = .white
        
        //CollectionView Item(cell) 설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentCollectionViewRankCell.self, forCellWithReuseIdentifier: "ContentCollectionViewRankCell")
        collectionView.register(ContentCollectionViewMainCell.self, forCellWithReuseIdentifier: "ContentCollectionViewMainCell")
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
        
        collectionView.collectionViewLayout = layout()
    }
    func getContents() -> [Content]{
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from : data) else {return []}
        return list
    }
    
    
    //각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() ->UICollectionViewLayout{
        return UICollectionViewCompositionalLayout{[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            
           
            switch self.contents[sectionNumber].sectionType{
            case . basic:
                print("1. basic 타입 섹션 반환")
                return self.createMainTypeSection()
            case .large:
                print("1. large 타입 섹션 반환")
                return self.createLargeTypeSection()
            case .rank:
                print("1. rank 타입 섹션 반환")
                return self.createRankTypeSection()
            case .main:
                print("1. main 타입 섹션 반환")
                return self.createMainTypeSection()
            }
            
        }
        
    }
    //basic section Layout 설정
    private func createBasicTypeSection() -> NSCollectionLayoutSection{
        //itme
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
        
    }
    
    //큰화면 section Layout 설정
    private func createLargeTypeSection() -> NSCollectionLayoutSection{
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    //순위 표시 section Layout 설정
    private func createRankTypeSection() -> NSCollectionLayoutSection{
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    //main Section Layout설정
    private func createMainTypeSection() -> NSCollectionLayoutSection{
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    //SectionHeader Layout 설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        //section header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
    
    func showAlert(title: String, message: String? = nil) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
}

//UICOllectionView DataSource, Delegate
extension HomeViewController {
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
    }
    //콜렉션 뷰 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType{
        case .basic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewMainCell", for: indexPath) as? ContentCollectionViewMainCell else {return UICollectionViewCell()}
            cell.imageView.image = mainItem?.image
            cell.descriptionLabel.text = self.presentGrapeName[indexPath.row]
            return cell
        case .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell()}
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewRankCell", for: indexPath) as? ContentCollectionViewRankCell else {return UICollectionViewCell()}
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1)
            return cell
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewMainCell", for: indexPath) as? ContentCollectionViewMainCell else {return UICollectionViewCell()}
            cell.imageView.image = mainItem?.image
            cell.descriptionLabel.text = self.predictGraphName[indexPath.row]
            return cell
        }
    }
    
    //헤더 뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else {fatalError("Could Not Dequeue Header")}
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
            
        }else {
            return UICollectionReusableView()
        }
    }
    
    //섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        self.showAlert(title: "\(sectionName)섹션의 \(indexPath.row + 1)번째 콘텐츠")
    }
}


