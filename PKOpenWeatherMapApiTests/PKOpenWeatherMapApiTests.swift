//
//  PKOpenWeatherMapApiTests.swift
//  PKOpenWeatherMapApiTests
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import XCTest
import CoreLocation

@testable import PKOpenWeatherMapApi

class PKOpenWeatherMapApiTests: XCTestCase {
    
    var weatherManager:PKWeatherManager?
    
    static let apiKey = "e2f86a4ff72f0ed3b28f38f4491f2ca0"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.weatherManager = PKWeatherManager(with: PKOpenWeatherMapApiTests.apiKey, preferredUnits: .standard)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}

//MARK: - Current Weather Api call tests
extension PKOpenWeatherMapApiTests {
    
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
    
    func testCurrentWeatherWithCityName() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        self.weatherManager?.requestCurrentWeather(cityName: "Szeged", countryCode: nil, completion: { (weather, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weather != nil)
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentWeatherWithCityZipCodeAndCountryCode() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        self.weatherManager?.requestCurrentWeather(zipCode: "6722", countryCode: "hu", completion: { (weather, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weather != nil)
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentWeatherWithCityZipCode() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        self.weatherManager?.requestCurrentWeather(zipCode: "6722", countryCode: nil, completion: { (weather, error) in
            
            if let error = error as? PKNetworkError {
                
                switch error {
                case .businessError(code: let code, message: let message):
                    XCTAssert(code == 404, "wrong error: \(message)")
                default:
                    XCTAssert(false, "\(error)")
                }
                
            } else if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weather != nil)
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentWeatherWithCoordinate() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        let coordinate = CLLocationCoordinate2D(latitude: 46.253, longitude: 20.1414)
        self.weatherManager?.requestCurrentWeather(coordinate: coordinate, completion: { (weather, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weather != nil)
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentWeatherWithGeofence() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        let topRight = CLLocationCoordinate2D(latitude: 46.253, longitude: 20.1414)
        let bottomLeft = CLLocationCoordinate2D(latitude: 45.253, longitude: 19.1414)
        self.weatherManager?.requestCurrentWeather(bottomLeftCoordinate: bottomLeft, topRightCoordinate: topRight, zoomLevel: 10, completion: { (weatherList, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weatherList != nil && ((weatherList?.cityWeatherList.count ?? 0) > 0))
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentWeatherAroundACoordinate() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        let coordinate = CLLocationCoordinate2D(latitude: 46.253, longitude: 20.1414)
        let cityCount = 10
        
        self.weatherManager?.requestCurrentWeather(coordinate: coordinate, cityCount: cityCount, completion: { (weatherList, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weatherList != nil && ((weatherList?.cityWeatherList.count ?? 0) == cityCount))
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentWeatherWithCityIds() {
        
        let expectation = XCTestExpectation(description: "Download weather data")
        
        let cityIds = [715429, 714419, 3054646, 3046446]
            
        self.weatherManager?.requestCurrentWeather(cityIds: cityIds, completion: { (weatherList, error) in
            
            if let error = error {
                XCTAssert(false, "\(error)")
            } else {
                XCTAssert(weatherList != nil && ((weatherList?.cityWeatherList.count ?? 0) == cityIds.count))
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
}
