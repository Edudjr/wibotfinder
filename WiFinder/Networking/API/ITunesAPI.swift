//
//  ITunesAPI.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class ITunesAPI: ITunesAPIProtocol {
    let baseURL = "https://itunes.apple.com"
    let provider: RequestProtocol?
    
    enum Endpoint: String {
        case search = "/search"
    }
    
    init(provider: RequestProtocol) {
        self.provider = provider
    }
    
    func getTracks(mediaType: MediaType, query: String, completion: @escaping CompletionWithTracks) {
        let url = baseURL + Endpoint.search.rawValue
        let params = [
            "media": mediaType.rawValue,
            "term": query
        ]
        
        provider?.request(url: url,
                          method: .get,
                          params: params,
                          headers: nil,
                          completion: { response in
                            
                            switch response.result {
                            case .success:
                                let code = response.response?.statusCode
                                if code != 200 && code != 201 {
                                    completion(nil)
                                    return
                                }
                                if let json = response.result.value as? [String: Any],
                                    let tracks = ITunesSearchResponseModel(object: json).results {
                                    completion(tracks)
                                } else {
                                    completion(nil)
                                }
                            case .failure:
                                completion(nil)
                            }
        })
    }
}
