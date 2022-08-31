//
//  ExchangeTests.swift
//  CountryTests
//
//  Created by Rodolphe Schnetzer on 30/08/2022.
//

import XCTest
@testable import Expat

class ExchangeTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    
    
    func testExchangeFailedIfError() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = ExchangeService(session: session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: nil, response: nil, error: TestFakeResponseData.error )
        sub.getExchange(devise: "") { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Expeted failure")
            }
            
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func testExchangeReceiveNoData() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = ExchangeService(session: session)
        
        URLProtocolStub.stub(data: nil, response: nil, error: nil)
        let expectation = expectation(description: "wait for request")
        
        sub.getExchange(devise: "USD") { result in
        guard case .failure(let error) = result else {
                XCTFail("TestReceiveNodata fail")
                
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testExchangeFailedIfResponseKO() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = ExchangeService(session: session)
        
        URLProtocolStub.stub(data: nil, response: TestFakeResponseData.responseKO, error: nil)
        let expectation = expectation(description: "wait for request")
        sub.getExchange(devise: "USD") { result in
            guard case .failure (let error) = result else {
                XCTFail("testgetExchangeReceiveResponseKO fail")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testExchangeReceiveDataAndResponseOK() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = ExchangeService(session: session)
        
        URLProtocolStub.stub(data: TestFakeResponseData.exchangeCorrectData, response: TestFakeResponseData.responseOK, error: nil)
        let expectation = expectation(description: "wait for request")
        sub.getExchange(devise: "USD", callback: { result in
            guard case .success (let data) = result else {
                XCTFail("testgetExchangeCorrectDataAndResponse fail")
                return
            }
            XCTAssertEqual(data, 1.081695)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
}
