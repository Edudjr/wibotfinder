//
//  ChatBotModel.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 16/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

protocol ChatBotModelDelegate: class {
    func shouldSearchFor(category: MediaType, query: String)
}

class ChatBotModel {
    
    enum Steps {
        case welcome, category, query, last
    }
    
    private var currentStep = Steps.welcome
    private var selectedCategory: MediaType?
    private var selectedQuery: String?
    
    var delegate: ChatBotModelDelegate?
    
    func getCurrentStep() -> Steps {
        return currentStep
    }
    
    func setCurrentStep(_ step: Steps) {
        currentStep = step
    }
    
    func getResponseFor(message: String) -> String {
        return getResponseFor(step: currentStep, message: message)
    }
    
    func getWelcomeMessage() -> String {
        currentStep = .category
        return "Hi there! My name is Bot. What would you like to search today? Movies, TV Shows or Music?"
    }
    
    private func getResponseFor(step: Steps, message: String) -> String {
        switch step {
        case .welcome:
            return getWelcomeMessage()
        case .category:
            return getResponseForCategoryStep(message)
        case .query:
            return getResponseForQueryStep(message)
        case .last:
            return "Searching for results!"
        }
    }
    
    private func getResponseForCategoryStep(_ message: String) -> String {
        let splited = message.split(separator: " ")
        var response = ""
        currentStep = .query
        
        for word in splited {
            let fixed = word.lowercased()
            switch fixed {
            case "movies":
                response = "Movies are great! What movie should I search for?"
                selectedCategory = MediaType.movie
                return response
            case "shows":
                response = "Hnmm, tv shows! Which one would you like to search?"
                selectedCategory = MediaType.tvShow
                return response
            case "music":
                response = "I like music! Which song or artist should I search for?"
                selectedCategory = MediaType.music
                return response
            default:
                break
            }
        }
        
        // Didn't find a proper response, still in "category" step
        response = "Sorry. Try something like Movies, TV Shows or Music!"
        currentStep = .category
        return response
    }
    
    private func getResponseForQueryStep(_ message: String) -> String {
        currentStep = .last
        selectedQuery = message
        if let category = selectedCategory, let query = selectedQuery {
            delegate?.shouldSearchFor(category: category, query: query)
            return "Getting results for \"\(message)\""
        }
        return "There was an error!"
    }
}
