//
//  ITunesAPITests.swift
//  WiFinderTests
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import XCTest
@testable import WiFinder

class ITunesAPITests: XCTestCase {
    let timeout = 10.0
    var request: RequestProtocol!
    var iTunesAPI: ITunesAPIProtocol!
    
    override func setUp() {
        super.setUp()
        
        //Usually I also create a Mock Request and pass it into provider, so I can test any scenario
        request = AlamofireRequest()
        iTunesAPI = ITunesAPI(provider: request)
    }
    
    func testGetMovie() {
        let exp = expectation(description: "Wait for response")
        iTunesAPI.getTracks(mediaType: .movie, query: "Harry Potter") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertNotEqual(tracks?.first?.trackId, nil)
            XCTAssertEqual(tracks?.first?.trackName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.artworkUrl100?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.artistName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.kind?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.longDescription?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.previewUrl?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.trackName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.kind, MediaKind.movie.rawValue)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
    
    func testGetTvShow() {
        let exp = expectation(description: "Wait for response")
        iTunesAPI.getTracks(mediaType: .tvShow, query: "Harry Potter") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertNotEqual(tracks?.first?.trackId, nil)
            XCTAssertEqual(tracks?.first?.trackName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.artworkUrl100?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.artistName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.kind?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.longDescription?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.previewUrl?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.trackName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.kind, MediaKind.tvShow.rawValue)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
    
    func testGetMusic() {
        let exp = expectation(description: "Wait for response")
        iTunesAPI.getTracks(mediaType: .music, query: "Harry Potter") { tracks in
            XCTAssertNotNil(tracks)
            XCTAssertNotEqual(tracks?.first?.trackId, nil)
            XCTAssertEqual(tracks?.first?.trackName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.artworkUrl100?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.artistName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.kind?.isEmpty, false)
            XCTAssertNil(tracks?.first?.longDescription)
            XCTAssertEqual(tracks?.first?.previewUrl?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.trackName?.isEmpty, false)
            XCTAssertEqual(tracks?.first?.kind, MediaKind.music.rawValue)
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeout)
    }
}
