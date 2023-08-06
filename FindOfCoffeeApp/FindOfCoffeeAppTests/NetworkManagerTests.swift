//
//  NetworkManagerTests.swift
//  FindOfCoffeeAppTests
//
//  Created by zombietux on 2020/12/20.
//

import XCTest
@testable import FindOfCoffeeApp

class NetworkManagerTests: XCTestCase {
    
    var client: NetworkManager!

    override func setUp() {
        client = NetworkManager()
    }

    //x=126.95738671650311&y=37.507476806640625&radius=1000&page=1
    func testFetchsData() {
        let exp = expectation(description: "API Result received")
        client.fetchMapDocuments(page: 1, x: 126.95738671650311, y: 37.507476806640625) { result in
            exp.fulfill()
            switch result {
            case .success(let response):
                
                XCTAssert(response.documents.count == 15)
             
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 3.0)
    }
}
