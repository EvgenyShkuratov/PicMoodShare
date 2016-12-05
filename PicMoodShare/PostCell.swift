//
//  PostCell.swift
//  PicMoodShare
//
//  Created by Evgeny Shkuratov on 12/2/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: CircleView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    
    }


}
