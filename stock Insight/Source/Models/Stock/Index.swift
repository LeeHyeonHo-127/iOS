import Foundation


struct IndexURLStrings: Codable{
    var KOSPI: String
    var KOSDAQ: String
    var KOSPI200: String
}

struct IndexURLs{
    var KOSPI: URL
    var KOSDAQ: URL
    var KOSPI200: URL
}

struct IndexData{
    var KOSPI: [[Date : Double]]
    var KOSDAQ: [[Date : Double]]
    var KOSPI200: [[Date: Double]]
}
