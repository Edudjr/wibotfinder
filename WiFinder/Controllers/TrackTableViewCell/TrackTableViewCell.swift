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
        animateWidth(-20) { _ in }
    }
    
    func animateWidth(_ width: CGFloat, completion: @escaping(Bool) -> Void) {
        let duration = 1.0
        let delay = 0.0
        let damping = CGFloat(0.4)
        let velocity = CGFloat(1.0)
        let options = UIViewAnimationOptions.curveEaseIn
        self.thumbnail.frame.size.width += width
        
        UIView.animate(withDuration:duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: options,
                       animations: {
                        self.thumbnail.frame.size.width -= width
        }, completion: { success in
            completion(success)
        })
    }
}
