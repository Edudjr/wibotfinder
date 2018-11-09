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
    var trackCatalogModel: TrackCatalogModel!
    
    override func setUp() {
        super.setUp()
        
        //Usually I also create a Mock Request and pass it into provider, so I can test any scenario
        let request = AlamofireRequest()
        let iTunesAPI = ITunesAPI(provider: request)
        trackCatalogModel = TrackCatalogModel(iTunesAPI: iTunesAPI)
    }
    
    func testGetMovies() {
        let exp = expectation(description: "Wait for response")
        trackCatalogModel.getMovie(query: "John Wick") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertEqual(tracks?.first?.title.isEmpty, false)
            XCTAssertEqual(tracks?.first?.subtitle.isEmpty, false)
            XCTAssertEqual(tracks?.first?.thumbnail.isEmpty, false)
            XCTAssertEqual(tracks?.first?.preview.isEmpty, false)
            XCTAssertNotNil(tracks?.first?.id)
            XCTAssertNotNil(tracks?.first?.icon)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
}
