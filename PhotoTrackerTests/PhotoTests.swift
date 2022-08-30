//
//  PhotoTests.swift
//  PhotoTrackerTests
//
//  Created by Roberto Garcia on 31/08/2022.
//

import XCTest
@testable import PhotoTracker

class PhotoTests: XCTestCase {

    /// Test if photos are the same (same photoURL but not neccessary same id)
    func test01PhotosSameURL() throws {
        let photo1 = Photo(id: "photo_id", latitude: 1, longitude: 1, photoURL: "photo_url", title: "Photo Title")
        let photo2 = Photo(id: "photo_id", latitude: 1, longitude: 1, photoURL: "photo_url", title: "Photo Title")
        XCTAssertTrue(photo1 == photo2, "Photos are different")
    }
    
    /// Test if photos are the same (same photoURL but not neccessary same id)
    func test02PhotosSameURL() throws {
        let photo1 = Photo(id: "photo_id 1", latitude: 1, longitude: 1, photoURL: "photo_url", title: "Photo Title 1")
        let photo2 = Photo(id: "photo_id 2", latitude: 2, longitude: 2, photoURL: "photo_url", title: "Photo Title 2")
        XCTAssertTrue(photo1 == photo2, "Photos are different")
    }
    
    /// Test if photos are different
    func test03PhotosDifferentURL() throws {
        let photo1 = Photo(id: "photo_id", latitude: 1, longitude: 1, photoURL: "photo_url 1", title: "Photo Title")
        let photo2 = Photo(id: "photo_id", latitude: 1, longitude: 1, photoURL: "photo_url 2", title: "Photo Title")
        XCTAssertTrue(photo1 != photo2, "Photos has same url")
    }

}
