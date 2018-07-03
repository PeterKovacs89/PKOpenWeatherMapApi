//
//  PKWeatherManagerTests.swift
//  PKOpenWeatherMapApiTests
//
//  Created by PeterKovacs on 2018. 07. 03..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import XCTest

@testable import PKOpenWeatherMapApi

fileprivate class TestAssembler {
}

extension TestAssembler: PKNetworkAssembler {
    func resolve() -> PKNetworkManagerProtocol {
        return PKTestNetworkManager()
    }
}

class PKWeatherManagerTests: XCTestCase {

    var weatherManager:PKWeatherManager?
    
    fileprivate let assembler = TestAssembler()
    
    override func setUp() {
        self.weatherManager = PKWeatherManager(with: PKOpenWeatherMapApiTests.apiKey, preferredUnits: .standard, networkManager:assembler.resolve())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrentWeatherWithCityNameAndCountryCode() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        self.weatherManager?.requestCurrentWeather(cityName: "Szeged", countryCode: "hu", completion: { (weather, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weather != nil)
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

}
