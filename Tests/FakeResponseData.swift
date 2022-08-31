//
//  FakeResponseData.swift
//  CountryTests
//
//  Created by Rodolphe Schnetzer on 29/08/2022.
//

import Foundation

class TestFakeResponseData {
    
    // 1-simulate 2 types of responses
    static let responseOK = HTTPURLResponse(url: URL(string:"https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
    static let responseKO = HTTPURLResponse(url: URL(string:"https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])
    
    class DataError: Error { }
    static let error = DataError()
    
    static var articleCorrectData: Data {
        let bundle = Bundle(for: TestFakeResponseData.self)
        let url = bundle.url(forResource: "Article", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: TestFakeResponseData.self)
        let url = bundle.url(forResource: "RatesData", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: TestFakeResponseData.self)
        let url = bundle.url(forResource: "WeatherData", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var webcamCorrectData: Data {
        let bundle = Bundle(for: TestFakeResponseData.self)
        let url = bundle.url(forResource: "WebcamData", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    // 3-Json damaged
    static let incorrectData = "erreur".data(using: .utf8)
    
}
