//
//  DogLikeTest.swift
//  DogLikeTest
//
//  Created by Eggenschwiler Andre on 04.11.24.
//

import XCTest
@testable import DogLike

@MainActor
final class DogLikeTest: XCTestCase {
    var viewModel: DogViewModel?
    var greetingName: String?
    var breedUrl: String?
    
    
    override func setUpWithError() throws {
        viewModel = DogViewModel()
        greetingName = "Alice"
        breedUrl = "https://images.dog.ceo/breeds/pembroke/n02113023_2330.jpg"
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        greetingName = nil
        breedUrl = nil
    }
    
    func testExample() throws {
       
    }
    
    func testGreeting() throws {
        XCTAssertEqual(viewModel?.greeting(name: greetingName!), "Welcome to DogLike, Alice!")
    }
    
    func testBreedUrl() throws {
        XCTAssertEqual(viewModel?.extractBreedName(from: breedUrl!), "pembroke")
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

    
    
    
}
