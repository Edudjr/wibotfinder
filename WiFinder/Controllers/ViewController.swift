//
//  ViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var trackCatalogModel: TrackCatalogModel?
    var tracks: [TrackCatalogModel.Track]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trackCatalogModel = TrackCatalogModel()
        let provider = AlamofireRequest()
        trackCatalogModel?.iTunesAPI = ITunesAPI(provider: provider)
        
        trackCatalogModel?.getFilteredTracks(type: .all, query: "john wick", completion: { tracks in
            self.tracks = tracks
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackReusableCell", for: indexPath) as! TrackTableViewCell
        if let track = tracks?[indexPath.row] {
            cell.titleLabel.text = track.title
            cell.subtitleLabel.text = track.subtitle
        }
        
        return cell
    }
}
