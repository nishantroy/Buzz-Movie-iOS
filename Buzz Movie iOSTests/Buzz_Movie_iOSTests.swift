//
//  Buzz_Movie_iOSTests.swift
//  Buzz Movie iOSTests
//
//  Created by localadmin on 4/1/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import XCTest
@testable import Buzz_Movie_iOS

class Buzz_Movie_iOSTests: XCTestCase {
    
    
    //MARK: FoodTracker Tests
    
    //Testing initializer
    
    func testMovieInitialization() {
        let potentialMovie = Movie(name: "Titanic", rating: 3, image: nil)
        XCTAssertNotNil(potentialMovie)
        let potentialMovie2 = Movie(name: "", rating: 3, image: nil)
        XCTAssertNil(potentialMovie2, "Name is empty string")
        let potentialMovie3 = Movie(name: "sdf", rating: 3, image: nil)
        XCTAssertNotNil(potentialMovie3)
    }
    
}
