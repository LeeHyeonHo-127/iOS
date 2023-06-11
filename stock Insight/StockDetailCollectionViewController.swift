import UIKit


class StockDetailCollectionViewController: UICollectionViewController{
    var stocks: [Stock] = []
    var predictGraphName: [String] = ["시계열분석", "감성 분석", "현재 주가"]
    var presentGrapeName: [String] = ["코스피", "코스닥", "S&P 500"]
    var predictGrapeName: [String] = ["5d_predict_SE00", "Data_Sentimental", "Data_SE00"]
    var leadingIndex: LeadingIndex = LeadingIndex(KOSPI: [], KOSDAQ: [], SnP500: [])
    var customBlueColor = UIColor(red: 0.149, green: 0.098, blue: 1.0, alpha: 1.0)



    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터 가져오기
        getStocks()
        getLeadingIndex()
        
        //내비게이션 설정
        collectionView.backgroundColor = .white
        //CollectionView Item(cell) 설정
        collectionView.register(ShowLineChartCell.self, forCellWithReuseIdentifier: "ShowLineChartCell")
        collectionView.register(ShowLeadingLineChartCell.self, forCellWithReuseIdentifier: "ShowLeadingLineChartCell")
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "ArticleCell")
        collectionView.register(StockCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StockCollectionViewHeader")
        collectionView.register(LeadingIndexCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LeadingIndexCollectionViewHeader")
        collectionView.register(StockCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "StockCollectionViewFooter")

        collectionView.collectionViewLayout = layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "My Title"
        self.navigationController?.navigationBar.isHidden = false
        

    }

    
    
    //각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() ->UICollectionViewLayout{
        return UICollectionViewCompositionalLayout{[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            if sectionNumber == 0{
                return self.createBasicTypeSection()
            }else if sectionNumber == 2{
                print("============================")
                print("1. Article Section Create")
                return self.createArticleSection()
            }else{
                return self.createLeadingIndexTypeSection()

            }
        }
    }
    
    //MARK: LAYOUT 설정
    //주가 정보 섹션 생성
    private func createBasicTypeSection() -> NSCollectionLayoutSection{
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    //지수 정보 섹션 생성
    private func createLeadingIndexTypeSection() -> NSCollectionLayoutSection{
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
        let sectionHeader = self.createSectionHeader()
        let sectionFooter = self.createSectionFooter()
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        return section
    }
    //뉴스 기사 section
    private func createArticleSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 10
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        print("============================")
        print("2. Creat Section")

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
    // SectionFooter Layout 설정
    private func createSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        // Section footer 사이즈
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        // Section footer Layout
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            
        // Leading, Trailing 제약조건 설정
        let sectionFooterInset = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        sectionFooter.contentInsets = sectionFooterInset
        
        return sectionFooter
    }

    //MARK: 그외 함수
    //Show Alert 함수
    func showAlert(title: String, message: String? = nil) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
    //csvFile 파싱 함수
    func parseCSVFile(datasetName: String) -> [[Date: Double]] {
        var dictionaryArray: [[Date: Double]] = []

        guard let path = Bundle.main.path(forResource: datasetName, ofType: "csv") else {
            return dictionaryArray
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: .utf8)
            let lines = csvString.components(separatedBy: "\n")

            let trimmedLines = lines.map { line -> String in
                var trimmedLine = line
                if let commaIndex = line.firstIndex(of: ",") {
                    let startIndex = line.index(after: commaIndex)
                    trimmedLine = String(line[startIndex...])
                }
                return trimmedLine
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

            for line in trimmedLines[1...] {
                let temp = line.components(separatedBy: ",")
                let fields = temp.map { $0.replacingOccurrences(of: "\r", with: "") }

                if let dateString = fields.first, let valueString = fields.last,
                   let date = dateFormatter.date(from: dateString),
                   let value = Double(valueString) {
                    let dictionary: [Date: Double] = [date: value]
                    dictionaryArray.append(dictionary)
                }
            }
        } catch {
            print("Error reading CSV file: \(error)")
        }
        return dictionaryArray
    }
    //임시 함수
    func getLeadingIndex(){
        self.leadingIndex.KOSPI = [2813.83, 2850.38, 2872.87, 2891.96, 2889.14, 2877.47, 2875.47, 2886.30, 2892.12, 2906.57, 2917.80, 2933.37, 2932.13, 2956.98, 2987.51, 3016.39, 2996.23, 3005.97, 3019.64, 3033.93]
        self.leadingIndex.KOSDAQ = [2820.21, 2849.19, 2865.94, 2876.80, 2862.62, 2875.59, 2890.43, 2912.01, 2924.08, 2916.37, 2941.36, 2933.17, 2964.94, 2981.22, 2973.33, 2981.95, 2977.05, 2986.15, 2992.57, 3004.56]
        self.leadingIndex.SnP500 = [2812.13, 2845.67, 2852.89, 2885.77, 2895.21, 2903.28, 2911.15, 2924.34, 2913.88, 2925.40, 2941.77, 2952.74, 2962.43, 2975.48, 2983.51, 2992.15, 3003.54, 2998.47, 3012.32, 3015.88]
    }
    func getStocks(){
        let samsungPresentPrice = [2813.83, 2850.38, 2872.87, 2891.96, 2889.14, 2877.47, 2875.47, 2886.30, 2892.12, 2906.57, 2917.80, 2933.37, 2932.13, 2956.98, 2987.51, 3016.39, 2996.23, 3005.97, 3019.64, 3033.93]
        let stockPrice: StockPrice = StockPrice(grahpType: .presentPrice, price: samsungPresentPrice)
        let stockPriceList: [StockPrice] = [stockPrice]
        let stock:Stock = Stock(stockName: "삼성전자", stockPriceList: stockPriceList, bookMark: false, sentimentAnalysis: true)
        self.stocks.append(stock)

        let applePrice = [2813.83, 2850.38, 2872.87, 2891.96, 2889.14, 2877.47, 2875.47, 2886.30, 2892.12, 2906.57, 2917.80, 2933.37, 2932.13, 2956.98, 2987.51, 3016.39, 2996.23, 3005.97, 3019.64, 3033.93]
        let appleStockPrice: StockPrice = StockPrice(grahpType: .presentPrice, price: applePrice)
        let appleStockPriceList: [StockPrice] = [appleStockPrice]
        let appleStock:Stock = Stock(stockName: "APPLE", stockPriceList: appleStockPriceList, bookMark: false, sentimentAnalysis: true)
        self.stocks.append(appleStock)

        let teslaPrice = [2813.83, 2850.38, 2872.87, 2891.96, 2889.14, 2877.47, 2875.47, 2886.30, 2892.12, 2906.57, 2917.80, 2933.37, 2932.13, 2956.98, 2987.51, 3016.39, 2996.23, 3005.97, 3019.64, 3033.93]
        let teslaStockPrice: StockPrice = StockPrice(grahpType: .presentPrice, price: teslaPrice)
        let teslaStockPriceList: [StockPrice] = [teslaStockPrice]
        let teslaStock:Stock = Stock(stockName: "TESLA", stockPriceList: teslaStockPriceList, bookMark: false, sentimentAnalysis: true)
        self.stocks.append(teslaStock)
    }
}




//UICOllectionView DataSource, Delegate
extension StockDetailCollectionViewController {
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else if section == 1{
            return 1
        }else if section == 2{
            return 4
        }else{
            return 0
        }
    }
    
    //콜렉션 뷰 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowLineChartCell", for: indexPath) as? ShowLineChartCell else {return UICollectionViewCell()}
            cell.descriptionLabel.text = self.predictGraphName[indexPath.row]
            cell.section = 0
            cell.gradientColor = .systemBlue
            cell.datasetName = self.predictGrapeName[indexPath.row]
            if indexPath.row == 2{
                cell.isPredict = false
            }else{
                cell.isPredict = true
            }
            return cell
        }else if indexPath.section == 1{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowLeadingLineChartCell", for: indexPath) as? ShowLeadingLineChartCell else {return UICollectionViewCell()}
            cell.descriptionLabel.text = ""
            cell.section = 1
            cell.gradientColor = .systemCyan
            cell.datasetName = "Data_SE00"
            cell.prepareForReuse()
            return cell
        }else if indexPath.section == 2{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else {return UICollectionViewCell()}


            return cell
        }
        else{return UICollectionViewCell()}
    }
    
    //헤더 뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            if(indexPath.section == 0){
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeadingIndexCollectionViewHeader", for: indexPath) as? LeadingIndexCollectionViewHeader else {fatalError("Could Not Dequeue Header")}
                headerView.sectionNameLabel.text = stocks[0].stockName
                return headerView
            }else if(indexPath.section == 1){
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeadingIndexCollectionViewHeader", for: indexPath) as? LeadingIndexCollectionViewHeader else {fatalError("Could Not Dequeue Header")}
                headerView.sectionNameLabel.text = "주가 미리보기"
                return headerView
            }else{
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeadingIndexCollectionViewHeader", for: indexPath) as? LeadingIndexCollectionViewHeader else {fatalError("Could Not Dequeue Header")}
                headerView.sectionNameLabel.text = "관련 기사"
                return headerView
            }
        }else if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StockCollectionViewFooter", for: indexPath) as? StockCollectionViewFooter else {fatalError("Could Not Dequeue Footer")}
            footerView.backgroundColor = .white // Set the background color for the footer view
                return footerView
        }else{
            return UICollectionViewCell()
        }
    }
    
    //섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}





