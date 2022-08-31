//
//  WeatherTests.swift
//  CountryTests
//
//  Created by Rodolphe Schnetzer on 30/08/2022.
//

import XCTest
@testable import Expat

class WeatherTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    
    func testWeatherFailedIfError() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = WeatherService(session: session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: nil, response: nil, error: TestFakeResponseData.error )
        sub.getWeather(place: "") { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Expeted failure")
            }
        }
            expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)

        }
        
    func testWeatherReceiveNoData() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = WeatherService(session: session)
        
        URLProtocolStub.stub(data: nil, response: nil, error: nil)
        let expectation = expectation(description: "wait for request")
        
        sub.getWeather(place: "france") { result in
        guard case .failure(let error) = result else {
                XCTFail("TestReceiveNodata fail")
                
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testWeatherFailedIfResponseKO() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = WeatherService(session: session)
        
        URLProtocolStub.stub(data: nil, response: TestFakeResponseData.responseKO, error: nil)
        let expectation = expectation(description: "wait for request")
        sub.getWeather(place: "france") { result in
            guard case .failure (let error) = result else {
                XCTFail("testgetExchangeReceiveResponseKO fail")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testWeatherReceiveDataAndResponseOK() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = WeatherService(session: session)
        
        URLProtocolStub.stub(data: TestFakeResponseData.weatherCorrectData, response: TestFakeResponseData.responseOK, error: nil)
        let expectation = expectation(description: "wait for request")
        sub.getWeather(place: "france") { result in
            switch result {
            case .failure(let error):
                XCTFail("error TestNoData")
                XCTAssertNotNil(error)
                
            case .success(let data):
                XCTAssertEqual(data.main.temp, 25.99)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    }


