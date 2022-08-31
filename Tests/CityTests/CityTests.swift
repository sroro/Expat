//
//  CityTests.swift
//  CountryTests
//
//  Created by Rodolphe Schnetzer on 31/08/2022.
//

import XCTest
@testable import Expat

class CityTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    
    func testWeatherFailedIfError() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = CityService(session:session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: nil, response: nil, error: TestFakeResponseData.error )
        sub.getCity(city: "") { result in
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
        
    func testWeatherReceiveNoDataNoResponse() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = CityService(session: session)
        
        URLProtocolStub.stub(data: nil, response: nil, error: nil)
        let expectation = expectation(description: "wait for request")
        
        sub.getCity(city: "Dubai") { result in
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
        let sub = CityService(session: session)
        
        URLProtocolStub.stub(data: nil, response: TestFakeResponseData.responseKO, error: nil)
        let expectation = expectation(description: "wait for request")
        sub.getCity(city: "Dubai") { result in
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
        let sub = CityService(session: session)
        
        URLProtocolStub.stub(data: TestFakeResponseData.cityCorrectData, response: TestFakeResponseData.responseOK, error: nil)
        let expectation = expectation(description: "wait for request")
        sub.getCity(city: "Dubai") { result in
            switch result {
            case .failure(let error):
                XCTFail("error TestNoData")
                XCTAssertNotNil(error)
                
            case .success(let data):
                XCTAssertEqual(data.data[0].currency, "Dirhams")
                XCTAssertEqual(data.data[0].repas, "🍔 Repas = 9€")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
