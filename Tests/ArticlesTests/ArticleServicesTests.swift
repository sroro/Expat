//
//  ArticleServicesTests.swift
//  CountryTests
//
//  Created by Rodolphe Schnetzer on 29/08/2022.
//

import XCTest
@testable import Expat

class ArticleServicesTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }

    func testNoDataNOResponseErrorNotNil(){
        let configuarrion = URLSessionConfiguration.ephemeral
        configuarrion.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuarrion)
        let sut = ArticleService(session: session)
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
    
    
    
    
    
    
}
