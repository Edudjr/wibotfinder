//
//  ChatBotModelTests.swift
//  WiFinderTests
//
//  Created by Eduardo Domene Junior on 16/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import XCTest
@testable import WiFinder

class ChatBotModelTests: XCTestCase {
    let timeout = 10.0
    var chatBotModel: ChatBotModelProtocol!
    
    override func setUp() {
        super.setUp()
        chatBotModel = ChatBotModel()
    }
    
    func testWelcome() {
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.welcome)
        let response = chatBotModel.getWelcomeMessage()
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.category)
        XCTAssertEqual(response.isEmpty, false)
    }
    
    func testMovieCategory() {
        let _ = chatBotModel.getWelcomeMessage()
        let response = chatBotModel.getResponseFor(message: "movies")
        XCTAssertEqual(response, "Movies are great! What movie should I search for?")
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.query)
    }
    
    func testTvShowCategory1() {
        let _ = chatBotModel.getWelcomeMessage()
        let response = chatBotModel.getResponseFor(message: "tv shows")
        XCTAssertEqual(response, "Hnmm, tv shows! Which one would you like to search?")
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.query)
    }
    
    func testTvShowCategory2() {
        let _ = chatBotModel.getWelcomeMessage()
        let response = chatBotModel.getResponseFor(message: "shows")
        XCTAssertEqual(response, "Hnmm, tv shows! Which one would you like to search?")
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.query)
    }
    
    func testMusicCategory() {
        let _ = chatBotModel.getWelcomeMessage()
        let response = chatBotModel.getResponseFor(message: "music")
        XCTAssertEqual(response, "I like music! Which song or artist should I search for?")
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.query)
    }
    
    func testWrongCategory() {
        let _ = chatBotModel.getWelcomeMessage()
        let response = chatBotModel.getResponseFor(message: "skibidi")
        XCTAssertEqual(response, "Sorry. Try something like Movies, TV Shows or Music!")
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.category)
    }
    
    func testMovieCategoryAndQuery() {
        let _ = chatBotModel.getWelcomeMessage()
        let _ = chatBotModel.getResponseFor(message: "movies")
        let response = chatBotModel.getResponseFor(message: "john wick")
        XCTAssertEqual(response, "Getting results for \"john wick\"")
        XCTAssertEqual(chatBotModel.getCurrentStep(), ChatBotSteps.last)
    }
}
