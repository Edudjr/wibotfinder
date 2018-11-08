//
//  ITunesSearchResponseModel.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
import Marshal

struct ITunesSearchResponseModel: Unmarshaling {
    var resultCount: Int?
    var results: [ITunesTrackModel]?
}

extension ITunesSearchResponseModel {
    init(object: MarshaledObject){
        resultCount = try? object.value(for: "resultCount")
        results = try? object.value(for: "results")
    }
}
