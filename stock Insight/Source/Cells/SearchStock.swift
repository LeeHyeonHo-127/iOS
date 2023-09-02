import Foundation

struct SearchStock: Codable{
    var currentPrice: Double
    var change: Double
    var stockCode: String
    var newsURL: String
    var magazineURL: String
    var economisURL: String
}


struct SearchStock_Dummy{
    var currentPrice: Double
    var change: Double
    var stockCode: String
    var newsURL: String
    var magazineURL: String
    var economisURL: String
}

