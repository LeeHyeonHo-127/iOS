import UIKit

struct Stock: Codable{ //한 종목에 대한 데이터 구조체
    var stockName: String
    var stockCode: String
    var currentPrice: Double
    var change: Double
    var changePercentage: Double
    
    var predict5: [Double]
    var predict10: [Double]
    
    var newsUrl: String //MK
    var magazineUrl: String //한경
    var economistUrl: String //이코노미스트
}


struct Stock_Dummy{ //한 종목에 대한 데이터 구조체
    var stockName: String
    var stockCode: String
    var currentPrice: Double
    var change: Double
    var changePercentage: Double
    
    var dayFivePrices: [[Date:Double]]
    var dayTenPrices: [[Date:Double]]
    var Prices: [[Date:Double]]
    
    var newsUrl: String //MK
    var magazineUrl: String //한경
    var economistUrl: String //이코노미스트
}




/*
stockName

stockCode

currentPrice

change

changePercentage

//현재 주가

dayFivePrices

dayTenPrices

//감성분석

newsUrl(Mk)

magazineUrl(한경)

economistUrl(이코노미스트)
*/
