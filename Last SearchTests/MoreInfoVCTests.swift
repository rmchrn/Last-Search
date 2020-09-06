//
//  MoreInfoVCTests.swift
//  Last SearchTests
//
//  Created by Ramcharan Reddy Gaddam on 06/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import XCTest
@testable import Last_Search

class MoreInfoVCTests: XCTestCase {

    var sut: MoreInfoViewController?
    
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(withIdentifier: "MoreInfoViewController") as? MoreInfoViewController
    }

    override func tearDown() {
        sut = nil
    }

    func testGetInfoAlbums() {
        // pre-conditions
        sut?.albumSelected = "Believe"
        sut?.artistSelected = "Disturbed"
        sut?.updateSelectedType()
        _ = sut?.view
        let expectation = XCTestExpectation(description: "searchVC.getMoreInfoAlbums")
        //Test
        sut?.getMoreInfo(completion: {
            expectation.fulfill()
            XCTAssert((self.sut?.nameLabel.text?.count ?? 0) > 0)
        })
        wait(for: [expectation], timeout: 30)
    }

    func testGetInfoArtists() {
        sut?.trackSelected = "Believer"
        sut?.artistSelected = "Imagine Dragons"
        sut?.updateSelectedType()
        _ = sut?.view
        let expectation = XCTestExpectation(description: "searchVC.getMoreInfoArtists")
        //Test
        sut?.getMoreInfo(completion: {
            expectation.fulfill()
            XCTAssert((self.sut?.nameLabel.text?.count ?? 0) > 0)
        })
        wait(for: [expectation], timeout: 30)
    }
    
    func testGetInfoTracks() {
        sut?.artistSelected = "Choir of Young Believers"
        sut?.updateSelectedType()
        _ = sut?.view
        let expectation = XCTestExpectation(description: "searchVC.getMoreInfoTracks")
        //Test
        sut?.getMoreInfo(completion: {
            expectation.fulfill()
            XCTAssert((self.sut?.nameLabel.text?.count ?? 0) > 0)
        })
        wait(for: [expectation], timeout: 30)
    }
    
}
