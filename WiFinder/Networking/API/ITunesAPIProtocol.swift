//
//  ITunesAPIProtocol.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionWithTracks = ([ITunesTrackModel]?)->Void

enum MediaType: String {
    case movie, music, tvShow
}

protocol ITunesAPIProtocol {
    func getTracks(mediaType: MediaType, query: String, completion: @escaping CompletionWithTracks)
}
