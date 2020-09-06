//
//  SearchVCTests.swift
//  Last SearchTests
//
//  Created by Ramcharan Reddy Gaddam on 06/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import XCTest
@testable import Last_Search

class SearchVCTests: XCTestCase {

    var sut:SearchTableViewController?
    
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = (sb.instantiateInitialViewController() as? UINavigationController)?.viewControllers[0] as? SearchTableViewController
    }

    override func tearDown() {
        sut = nil
    }
    
    func testAlbumSearch() {
        //pre-conditions or inputs
        sut?.selectedScopeBarTittle = "Album"
        let expectation = XCTestExpectation(description: "searchVC.getAlbums")
        //test
        if let params = sut?.createGetCallParams(withSearchkey: "believe") {
            sut?.getSearchResults(params, completion: {
                if let album = self.sut?.results?.results?.albummatches?.album {
                    expectation.fulfill()
                    XCTAssert(album.count > 0)
                }
            })
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func testArtistSearch() {
        //pre-conditions or inputs
        sut?.selectedScopeBarTittle = "Artist"
        let expectation = XCTestExpectation(description: "searchVC.getArtist")
        //test
        if let params = sut?.createGetCallParams(withSearchkey: "believe") {
            sut?.getSearchResults(params, completion: {
                if let artist = self.sut?.results?.results?.artistmatches?.artist {
                    expectation.fulfill()
                    XCTAssert(artist.count > 0)
                }
            })
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func testTrackSearch() {
        //pre-conditions or inputs
        sut?.selectedScopeBarTittle = "Track"
        let expectation = XCTestExpectation(description: "searchVC.getTrack")
        //test
        if let params = sut?.createGetCallParams(withSearchkey: "believe") {
            sut?.getSearchResults(params, completion: {
                if let track = self.sut?.results?.results?.trackmatches?.track {
                    expectation.fulfill()
                    XCTAssert(track.count > 0)
                }
            })
        }
        wait(for: [expectation], timeout: 30)
    }

}
