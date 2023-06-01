import UIKit

struct Stock{ //한 종목에 대한 데이터 구조체
    let stockName: String //종목 이름
    let stockPriceList: [StockPrice] //주가 데이터 리스트
        let bookMark: Bool //즐겨찾기 여부
        let sentimentAnalysis: Bool //감성분석 결과
}

struct StockPrice{
    let grahpType: GraphType //그래프 종류
        let price: [Double] //종가 리스트
        
        enum GraphType: String{
            case timeSeries30 //시계열 분석 데이터_30일 예측
            case timeSeries10 //시계열 분석 데이터_10일 예측
            case timeSeries5 //시계열 분석 데이터_5일 예측
            case presentPrice //현재 주가
        }
}


