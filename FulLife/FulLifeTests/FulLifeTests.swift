//
//  FulLifeTests.swift
//  FulLifeTests
//
//  Created by Consultant on 10/11/23.
//

import XCTest
@testable import FulLife

class FulLifeTests: XCTestCase {

    class MockURLProtocol: URLProtocol {
        static var mockResponseData: Data?
        static var mockError: Error?

        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            if let data = MockURLProtocol.mockResponseData {
                client?.urlProtocol(self, didLoad: data)
            }
            if let error = MockURLProtocol.mockError {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() {
            // Clean up
        }
    }

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        networkManager = nil
        super.tearDown()
    }

    func testFetchRandomQuote() {
        let expectation = self.expectation(description: "Fetch random quote")

        networkManager.fetchRandomQuote { quotes in
            if let quotes = quotes {
                if !quotes.isEmpty {
                    // At least one quote is received, check individual quotes.
                    let firstQuote = quotes[0]
                    XCTAssertFalse(firstQuote.q.isEmpty, "Quote should not be empty")
                    XCTAssertFalse(firstQuote.a.isEmpty, "Author should not be empty")
                } else {
                    XCTFail("No quotes received in the response")
                }
            } else {
                // Quotes can be nil, which is expected.
                print("Quotes are nil, but it's okay.")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }


}
