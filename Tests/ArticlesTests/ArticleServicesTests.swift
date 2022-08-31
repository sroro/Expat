//
//  ArticleServicesTests.swift
//  CountryTests
//
//  Created by Rodolphe Schnetzer on 29/08/2022.
//

import XCTest
@testable import Expat

class ArticleServicesTests: XCTestCase {

    // nettoie apres chaque fin de test les etats
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    

    func testNoDataNOResponseErrorNotNil(){
        
        // 1 configuration FakeSession
        let configuarrion = URLSessionConfiguration.ephemeral
        configuarrion.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuarrion)
        let sut = ArticleService(session: session)
        
        //2 Utilisation Protocol
        URLProtocolStub.stub(data: nil, response: nil, error: NSError(domain: "Error", code: 0))
        
        let exp = expectation(description: "wait for request")
        sut.getArticle(keyword: "") { result in
            switch result {
            case let .failure(error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Expeted failure")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    
    
    func testGetArticleReceiveNoData() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = ArticleService(session: session)
        
        URLProtocolStub.stub(data: nil, response: nil, error: nil)
        let expaction = expectation(description: "wait for request")
        sut.getArticle(keyword: "France") { result in
            guard case .failure (let error) = result else {
                XCTFail("testgetExchangeReceiveNoData fail")
                return
            }
            XCTAssertNotNil(error)
            
            expaction.fulfill()
        }
        wait(for: [expaction], timeout: 1.0)
        
    }
    
    
    
    func testReceiveDataButResponseKO() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = ArticleService(session: session)
        
        URLProtocolStub.stub(data: TestFakeResponseData.articleCorrectData, response: TestFakeResponseData.responseKO, error: nil)
        
        let expectation = expectation(description: "wait for request")
        
        sut.getArticle(keyword: "France") { result in
            guard case .failure (let error) = result else {
                XCTFail("testgetExchangeReceiveNoData fail")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testReceiveDataAndresponseOK() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = ArticleService(session: session)
        
        URLProtocolStub.stub(data: TestFakeResponseData.articleCorrectData, response: TestFakeResponseData.responseOK, error: nil)
        
        let expectation = expectation(description: "wait for request")
        
        sut.getArticle(keyword: "France") { result in
            guard case .success (let data) = result else {
                XCTFail("testgetExchangeCorrectDataAndResponse fail")
                return
            }
            XCTAssertEqual(data.articles[0].title, "Quinté+: PRIX DES HAUTS-DE-FRANCE")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    
    
    
}
