//
//  PKOpenWeatherMapApiTests.swift
//  PKOpenWeatherMapApiTests
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import XCTest
@testable import PKOpenWeatherMapApi

class PKOpenWeatherMapApiTests: XCTestCase {
    
    var weatherManager:PKWeatherManager?
    
    static let apiKey = ""
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.weatherManager = PKWeatherManager(with: PKOpenWeatherMapApiTests.apiKey, preferredUnits: .standard)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        self.weatherManager?.requestCurrentWeather(cityName: "Szeged", countryCode: "hu", completion: { (weather, error) in
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
