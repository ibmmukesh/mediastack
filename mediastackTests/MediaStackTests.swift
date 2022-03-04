//
//  mediastackTests.swift
//  mediastackTests
//
//  Created by Mukesh Lokare on 02/03/22.
//

///MediaStackTests class can contain all the functional test cases 
///


import XCTest
@testable import mediastack

class MediaStackTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIValidator_WithValidCountryProvided(){
        //Arrange
        let apiValidator = NewsAPIValidator()
        //Act
        let isCountryValid = apiValidator.isCountryValid(countries: ["us"])
        //Assert
        XCTAssertTrue(isCountryValid,"Here isCountryValid() should return true for valid input")
    }
    
    func testAPIValidator_WithLanguageProvided(){
        //Arrange
        let apiValidator = NewsAPIValidator()
        //Act
        let isLanguagesValid = apiValidator.isLanguagesValid(languages: "en")
        //Assert
        XCTAssertTrue(isLanguagesValid,"Here isLanguagesValid() should return true for valid input")
    }
    
    func testAPIValidator_WithValidCategoryProvided(){
        //Arrange
        let apiValidator = NewsAPIValidator()
        //Act
        let isCountryValid = apiValidator.isCategoriesValid(category: "sport,business")
        //Assert
        XCTAssertTrue(isCountryValid,"Here isCountryValid() should return true for valid input")
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
