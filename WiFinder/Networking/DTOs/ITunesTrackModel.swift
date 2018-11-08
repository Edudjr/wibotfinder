//
//  ITunesTrackModel.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
import Marshal

struct ITunesTrackModel: Unmarshaling {
    var trackId: Int?
    var kind: String?
    var artworkUrl100: String?
    var artistName: String?
    var trackName: String?
    var longDescription: String?
    var previewUrl: String?
}

extension ITunesTrackModel {
    init(object: MarshaledObject){
        trackId = try? object.value(for: "trackId")
        kind = try? object.value(for: "kind")
        artworkUrl100 = try? object.value(for: "artworkUrl100")
        artistName = try? object.value(for: "artistName")
        trackName = try? object.value(for: "trackName")
        longDescription = try? object.value(for: "longDescription")
        previewUrl = try? object.value(for: "previewUrl")
    }
}
