//
//  TrackCatalogModelTests.swift
//  WiFinderTests
//
//  Created by Eduardo Domene Junior on 08/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import XCTest
@testable import WiFinder

class TrackCatalogModelTests: XCTestCase {
    let timeout = 10.0
    var trackCatalogModel: CatalogModel!
    
    override func setUp() {
        super.setUp()
        
        //Usually I also create a Mock Request and pass it into provider, so I can test any scenario
        let request = AlamofireRequest()
        let iTunesAPI = ITunesAPI(provider: request)
        trackCatalogModel = CatalogModel(iTunesAPI: iTunesAPI)
    }
    
    func testGetMovies() {
        let exp = expectation(description: "Wait for response")
        trackCatalogModel.getFilteredTracks(type: .movie, query: "John") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertEqual(tracks?.first?.title.isEmpty, false)
            XCTAssertEqual(tracks?.first?.subtitle.isEmpty, false)
            XCTAssertEqual(tracks?.first?.thumbnail.isEmpty, false)
            XCTAssertEqual(tracks?.first?.preview.isEmpty, false)
            XCTAssertNotNil(tracks?.first?.id)
            XCTAssertNotNil(tracks?.first?.icon)
            XCTAssertEqual(tracks?.first?.type, MediaType.movie)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
    
    func testGetTvShows() {
        let exp = expectation(description: "Wait for response")
        trackCatalogModel.getFilteredTracks(type: .tvShow, query: "John") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertEqual(tracks?.first?.title.isEmpty, false)
            XCTAssertEqual(tracks?.first?.subtitle.isEmpty, false)
            XCTAssertEqual(tracks?.first?.thumbnail.isEmpty, false)
            XCTAssertEqual(tracks?.first?.preview.isEmpty, false)
            XCTAssertNotNil(tracks?.first?.id)
            XCTAssertNotNil(tracks?.first?.icon)
            XCTAssertEqual(tracks?.first?.type, MediaType.tvShow)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
    
    func testGetMusic() {
        let exp = expectation(description: "Wait for response")
        trackCatalogModel.getFilteredTracks(type: .music, query: "John") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertEqual(tracks?.first?.title.isEmpty, false)
            XCTAssertEqual(tracks?.first?.subtitle.isEmpty, false)
            XCTAssertEqual(tracks?.first?.thumbnail.isEmpty, false)
            XCTAssertEqual(tracks?.first?.preview.isEmpty, false)
            XCTAssertNotNil(tracks?.first?.id)
            XCTAssertNotNil(tracks?.first?.icon)
            XCTAssertEqual(tracks?.first?.type, MediaType.music)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
    
    func testEmptyState() {
        let exp = expectation(description: "Wait for response")
        trackCatalogModel.getFilteredTracks(type: .tvShow, query: "John Wick!") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertEqual(tracks?.count, 0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
}
