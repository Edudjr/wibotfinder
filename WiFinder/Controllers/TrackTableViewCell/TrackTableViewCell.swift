//
//  TrackTableViewCell.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 08/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func layoutSubviews() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        thumbnail.isUserInteractionEnabled = true
        thumbnail.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        animate()
    }
    
    func animate() {
        self.thumbnail.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(3.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.thumbnail.transform = CGAffineTransform.identity
                        
        }, completion: nil)
    }
}
