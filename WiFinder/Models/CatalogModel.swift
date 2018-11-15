//
//  CatalogModel.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 08/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//


import UIKit

protocol CatalogModelProtocol {
    func getFilteredTracks(type: MediaType, query: String, completion: @escaping([TrackEntity]?) -> Void)
}

class CatalogModel: CatalogModelProtocol {
    var iTunesAPI: ITunesAPIProtocol?
    
    init(iTunesAPI: ITunesAPIProtocol) {
        self.iTunesAPI = iTunesAPI
    }
    
    func getFilteredTracks(type: MediaType, query: String, completion: @escaping([TrackEntity]?) -> Void) {
        iTunesAPI?.getTracks(mediaType: type, query: query, completion: { tracks in
            guard let tracks = tracks else {
                completion(nil)
                return
            }
            var response = [TrackEntity]()
            for iTrack in tracks {
                if let track = self.trackFrom(iTrack) {
                    response.append(track)
                }
            }
            completion(response)
        })
    }
}

// MARK: Converter
extension CatalogModel {
    func trackFrom(_ iTunesTrack: ITunesTrackModel) -> TrackEntity? {
        guard let id = iTunesTrack.trackId,
            let trackName = iTunesTrack.trackName,
            let artistName = iTunesTrack.artistName,
            let artwork = iTunesTrack.artworkUrl100,
            let kind = iTunesTrack.kind,
            let previewUrl = iTunesTrack.previewUrl else {
                return nil
        }
        let longDescription = iTunesTrack.longDescription ?? ""
        
        var icon: UIImage = #imageLiteral(resourceName: "empty-icon")
        var title: String = ""
        var subtitle: String = ""
        var type: MediaType = MediaType.none
        
        
        switch kind {
        case MediaKind.movie.rawValue:
            title = trackName
            subtitle = longDescription
            icon = #imageLiteral(resourceName: "video-icon")
            type = .movie
        case MediaKind.music.rawValue:
            title = trackName
            subtitle = artistName
            icon = #imageLiteral(resourceName: "music-icon")
            type = .music
        case MediaKind.tvShow.rawValue:
            title = artistName
            subtitle = longDescription
            icon = #imageLiteral(resourceName: "television-icon")
            type = .tvShow
        default:
            break
        }
        
        let entity = TrackEntity(id: id,
                           title: title,
                           subtitle: subtitle,
                           thumbnail: artwork,
                           icon: icon,
                           type: type,
                           preview: previewUrl)
        return entity
    }
}
