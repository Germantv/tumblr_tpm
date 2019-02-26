//
//  PhotoCell.swift
//  TPM_Tumblr
//
//  Created by German Flores on 11/5/18.
//  Copyright © 2018 German Flores. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var hashtag: UILabel!
    @IBOutlet weak var notes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2745098039, blue: 0.3647058824, alpha: 1)
        self.contentView.backgroundColor = UIColor.white
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
