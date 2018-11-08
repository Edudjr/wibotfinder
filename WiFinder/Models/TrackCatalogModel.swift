//
//  TrackCatalogModel.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 08/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

class TrackCatalogModel {
    
    var iTunesAPI: ITunesAPIProtocol?
    
    struct Track {
        let id: Int
        let title: String
        let subtitle: String
        let thumbnail: String
        let icon: String
        let type: MediaType
    }
    
    func getFilteredTracks(type: MediaType, query: String, completion: @escaping([Track]?) -> Void) {
        iTunesAPI?.getTracks(mediaType: .all, query: query, completion: { tracks in
            guard let tracks = tracks else {
                completion(nil)
                return
            }
            var response = [Track]()
            for track in tracks {
                switch track.kind {
                case MediaKind.movie.rawValue:
                    if let entity = self.musicEntityFrom(track) {
                        response.append(entity)
                    }
                default:
                    break
                }
            }
            completion(response)
        })
    }
}

// MARK: Converters
extension TrackCatalogModel {
    func musicEntityFrom(_ track: ITunesTrackModel) -> Track? {
        guard let trackId = track.trackId,
            let trackName = track.trackName,
            let artistName = track.artistName,
            let artwork = track.artworkUrl100 else {
                return nil
        }
            
            
        let entity = Track(id: trackId,
                            title: trackName,
                            subtitle: artistName,
                            thumbnail: artwork,
                            icon: "",
                            type: .music)
        return entity
    }
}
