//
//  ViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedMediaType: MediaType?
    var enteredQuery: String?
    
    var catalogModel: CatalogModel?
    var tracks: [CatalogModel.Track]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let provider = AlamofireRequest()
        let iTunesAPI = ITunesAPI(provider: provider)
        catalogModel = CatalogModel(iTunesAPI: iTunesAPI)
        
        if let type = selectedMediaType, let query = enteredQuery {
            catalogModel?.getFilteredTracks(type: type, query: query, completion: { tracks in
                self.tracks = tracks
            })
        }
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
            if let url = URL(string: track.thumbnail) {
                cell.thumbnail.kf.setImage(with: url)
            }
            cell.icon.image = track.icon
            cell.animate()
        }
        
        return cell
    }
}
