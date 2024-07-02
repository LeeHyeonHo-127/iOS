//
//  ViewController.swift
//  YahooFinancePractice
//
//  Created by 이현호 on 2023/09/20.
//

import UIKit
import SwiftYFinance
import Foundation
import Alamofire
import SwiftCSV

class ViewController: UIViewController {
    
    var url = "https://5216-218-55-7-205.ngrok-free.app/download/KOSPI_data.csv"
    var data: [[Date:Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var data = self.parseCSVFile(datasetName: "KOSPI_data")
//        data = data.reversed()
//        print(data)
        
        self.downloadAndParseCSV(url: url)
        
        let today = Date()
        
        print("오늘 날짜: \(String(today))")
        print(type(of: String(today)))
        

//        self.getChart()
    }
    
    func downloadAndParseCSV(url: String) {
        var dictionaryArray: [[Date: Double]] = []
        
        // Alamofire를 사용하여 CSV 파일 다운로드
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let csvString = String(data: data, encoding: .utf8) {
                    print("csvString = \(csvString)")
                    
                    let lines = csvString.components(separatedBy: "\n")
                    print("lines = \(lines)")
                        
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"

                    for line in lines[1...] {
                        let temp = line.components(separatedBy: ",")
                        var fields = temp.map { $0.replacingOccurrences(of: "\r", with: "") }
                        fields = fields.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                            
                        print("fields = \(fields)")

                        if let dateString = fields.first, let valueString = fields.last,
                            let date = dateFormatter.date(from: dateString),
                           let value = Double(valueString) {
                            print("let in")
                            let dictionary: [Date: Double] = [date: value]
                            dictionaryArray.append(dictionary)
                        }
                        self.data = dictionaryArray
                        print("self.data = \(self.data)")
                    }
                }
            case .failure(let error):
                print("다운로드 오류: \(error)")
            }
        }
    }
    
    //CSV 파싱 함수_index
    func parseCSVFile(datasetName: String) -> [[Date: Double]] {
        var dictionaryArray: [[Date: Double]] = []

        guard let path = Bundle.main.path(forResource: datasetName, ofType: "csv") else {
            return dictionaryArray
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: .utf8)
            print("csvString = \(csvString)")
            
            let lines = csvString.components(separatedBy: "\n")
            print("lines = \(lines)")

            let trimmedLines = lines.map { line -> String in
                var trimmedLine = line
                if let commaIndex = line.firstIndex(of: ",") {
                    let startIndex = line.index(after: commaIndex)
                    trimmedLine = String(line[startIndex...])
                }
                return trimmedLine
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            for line in lines[1...] {
                let temp = line.components(separatedBy: ",")
                var fields = temp.map { $0.replacingOccurrences(of: "\r", with: "") }
                fields = fields.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                
                print("fields = \(fields)")

                if let dateString = fields.first, let valueString = fields.last,
                   let date = dateFormatter.date(from: dateString),
                   let value = Double(valueString) {
                    print("let in")
                    let dictionary: [Date: Double] = [date: value]
                    dictionaryArray.append(dictionary)
                }
            }
        } catch {
            print("Error reading CSV file: \(error)")
        }
        return dictionaryArray
    }
    
    
    
    func getChart(){
        
        // 삼성전자 종목 심볼
        let symbol = "KOSPI.KS" // 삼성전자 종목 심볼, ".KS"는 한국 주식 시장을 나타냅니다.
        
        // 시작 및 종료 날짜 설정
        let dateFormatter_onlyDate = DateFormatter()
        dateFormatter_onlyDate.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter_DateAndTime = DateFormatter()
        dateFormatter_DateAndTime.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
        
        let startDate = dateFormatter_onlyDate.date(from: "2020-01-01")
        let endDate = Date()
        
        let calendar = Calendar.current
        
        
        // 종가 데이터 가져오기
        SwiftYFinance.chartDataBy(identifier: symbol, start: startDate!, end: endDate, interval: .oneday){
            data, error in
            if let chartData = data{
                let transformedData: [[Date: Double]] = chartData.compactMap { data in
                    guard let date = data.date, let close = data.close else {
                        return [Date: Double]() // 날짜나 종가 데이터가 없으면 무시
                    }
                    
//                    let date_string = dateFormatter_DateAndTime.string(from: date)
//                    let date_split = date_string.split(separator: " ").map{String($0)}
//                    
//                    print("date_split[0] = \(date_split[0])")
//                    
//                    guard let date_onlyDate = dateFormatter_onlyDate.date(from: date_string) else {return nil}
//                    print("date_onlyDate = \(date_onlyDate)")
//                    
                    return [date: Double(close)]
                }
                print(transformedData)
            }
        }
    }
    
}

