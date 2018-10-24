//
//  TableViewCell.swift
//  Instagram
//
//  Created by Anthony Lee on 10/22/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["media"] as? PFFile
            self.captionLabel.text = instagramPost["caption"] as? String
            self.photoView.loadInBackground()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
