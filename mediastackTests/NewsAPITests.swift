//
//  NewsAPITests.swift
//  mediastackTests
//
//  Created by Mukesh Lokare on 04/03/22.
//

///NewsAPITests class can contain all the API call test cases that are listed in News Module.
///


import XCTest
@testable import mediastack

class NewsAPITests: XCTestCase {

    var newsWebService: NewsWebservices!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        newsWebService = NewsWebservices()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        newsWebService = nil
    }

    func testNewsApi_ValidateSuccess() throws {
      // Arrange
      let expectation = expectation(description: "Completion handler invoked")
      var success: Bool?
      var responseError: Error?

        let parameter = NewsParameter(access_key: AppConstant.apiAccessKey, sources: "", categories: "", countries: "", languages: "", keywords: "", sort: "", offset: 0, limit: 10)

      // Act
        newsWebService.liveNews(parameter: parameter) { response in
            switch response {
            case .success(value: let response) :
                if let _ = response.data{
                    success = true
                }
                break
            case .failure(let error):
                responseError = error
                break
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)

      // Assert
      XCTAssertNil(responseError)
      XCTAssertTrue(success ?? true,"Here isLanguagesValid() should return true for valid input")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
