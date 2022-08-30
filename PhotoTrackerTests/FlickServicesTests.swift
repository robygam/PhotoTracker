//
//  FlickServicesTests.swift
//  PhotoTrackerTests
//
//  Created by Roberto Garcia on 31/08/2022.
//

import XCTest
@testable import PhotoTracker
import CoreLocation

class FlickServicesTests: XCTestCase {
    var sut: FlickrServices?

    override func setUpWithError() throws {
        sut = FlickrServices()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    /// Test to check if request is performed correctly
    func test01CanSendRequest() throws {
        
        let promise = expectation(description: "Test succeed")
        
        sut?.searchPhotos(latitude: 30, longitude: -120) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error description: \(error)")
            case .success(let response):
                if response.stat != "ok" {
                    XCTFail("Request failed")
                } else {
                    promise.fulfill()
                }
            }
        }
        
        wait(for: [promise], timeout: 3)
    }
    
    /// Test to check if response contains photos ofr Apple center coordinates
    func test02CanGetPhotos() throws {
        let promise = expectation(description: "Response contains photos")
        
        sut?.searchPhotos(latitude: 37.33182, longitude: 122.03118) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error description: \(error)")
            case .success(let response):
                if response.stat != "ok" {
                    XCTFail("Request failed")
                } else {
                    XCTAssertFalse(response.photos.photoList.isEmpty, "photoList is empty")
                    promise.fulfill()
                }
            }
        }
        
        wait(for: [promise], timeout: 3)
    }
    
    /// Test to check random photo method
    func test03RandomPhoto() throws {
        let promise = expectation(description: "Random photo contained in response")
        
        sut?.searchPhotos(latitude: 37.33182, longitude: 122.03118) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error description: \(error)")
            case .success(let response):
                if response.stat != "ok" {
                    XCTFail("Request failed")
                } else {
                    XCTAssertFalse(response.photos.photoList.isEmpty, "photoList is empty")
                    let randomPhoto = response.randomTitledPhoto
                    XCTAssertNotNil(randomPhoto)
                    let isContained: Bool = response.photos.photoList.contains(where: { $0 == randomPhoto })
                    XCTAssertTrue(isContained, "random photo is in photo list")
                    promise.fulfill()
                }
            }
        }
        
        wait(for: [promise], timeout: 3)
    }
    
    /// Test to check random photos method
    func test04RandomPhotos() throws {
        let promise = expectation(description: "Random photo contained in response")
        
        sut?.searchPhotos(latitude: 37.33182, longitude: 122.03118) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error description: \(error)")
            case .success(let response):
                if response.stat != "ok" {
                    XCTFail("Request failed")
                } else {
                    XCTAssertFalse(response.photos.photoList.isEmpty)
                    let randomPhoto1 = response.randomTitledPhoto
                    XCTAssertNotNil(randomPhoto1)
                    let randomPhoto2 = response.randomTitledPhoto
                    XCTAssertNotNil(randomPhoto2
                    )
                    
                    let areContained: Bool = response.photos.photoList.contains(where: { $0 == randomPhoto1 || $0 == randomPhoto2 })
                    XCTAssertTrue(areContained, "random photos are in photo list")
                    XCTAssertTrue(randomPhoto1 != randomPhoto2, "Photos are the same")
                    
                    promise.fulfill()
                }
            }
        }
        
        wait(for: [promise], timeout: 3)
    }
}
