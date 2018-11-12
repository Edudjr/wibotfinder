//
//  ViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedMediaType: MediaType?
    var enteredQuery: String?
    var selectedTrack: CatalogModel.Track?
    var webView: WKWebView?
    var fadedBackground: UIView?
    var activityView: UIActivityIndicatorView?
    
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
        
        webView?.navigationDelegate = self
        
        if let type = selectedMediaType, let query = enteredQuery {
            catalogModel?.getFilteredTracks(type: type, query: query, completion: { tracks in
                self.tracks = tracks
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PreviewViewController {
            vc.previewUrl = selectedTrack?.preview
        }
    }
    
    func setupTapGesture(view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeWebView))
        view.addGestureRecognizer(tap)
    }
    
    func loadVideoInWebKit(url: String) {
        addFadedBackground()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []

        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 300), configuration: webConfiguration)

        if let webView = webView {
            webView.translatesAutoresizingMaskIntoConstraints = false
            //webView.contentMode = UIViewContentMode.scaleAspectFill
            webView.backgroundColor = UIColor.black
            webView.navigationDelegate = self
            self.view.addSubview(webView)

            let width = self.view.frame.width-20
            let height = width/2

            webView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            webView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            webView.heightAnchor.constraint(equalToConstant: height).isActive = true
            webView.widthAnchor.constraint(equalToConstant: width).isActive = true

            showActivityIndicator(on: webView)
            let html = """
            <body style="margin: 0px; background-color: black;">
            <video playsinline controls width="100%" height="100%" src="\(url)"> </video>
            </body>
            """
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    func addFadedBackground() {
        fadedBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        fadedBackground?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupTapGesture(view: fadedBackground!)
        self.view.addSubview(fadedBackground!)
    }
    
    func removeFadedBackground() {
        fadedBackground?.removeFromSuperview()
        fadedBackground = nil
    }
    
    func showActivityIndicator(on view: UIView) {
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        if let activityView = activityView, let webView = webView {
            activityView.translatesAutoresizingMaskIntoConstraints = false
            webView.addSubview(activityView)
            activityView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
            activityView.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
            activityView.startAnimating()
        }
    }
    
    func hideAcivityIndicator() {
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
    @objc func closeWebView() {
        removeFadedBackground()
        webView?.removeFromSuperview()
        webView = nil
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let track = tracks?[indexPath.row] {
            selectedTrack = track
            loadVideoInWebKit(url: track.preview)
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideAcivityIndicator()
    }
}
