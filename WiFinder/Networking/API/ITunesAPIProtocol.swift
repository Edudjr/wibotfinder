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
    case all, movie, music, tvShow
}

enum MediaKind: String {
    case movie = "feature-movie"
    case music = "song"
    case tvShow = "tv-episode"
}

protocol ITunesAPIProtocol {
    func getTracks(mediaType: MediaType, query: String, completion: @escaping CompletionWithTracks)
}
