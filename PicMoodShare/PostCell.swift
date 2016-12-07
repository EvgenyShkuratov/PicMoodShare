//
//  PostCell.swift
//  PicMoodShare
//
//  Created by Evgeny Shkuratov on 12/2/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: CircleView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: CircleView!
    
    
    var post: Post!
    var likesRef: FIRDatabaseReference!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tapOne.numberOfTapsRequired = 1
        tapTwo.numberOfTapsRequired = 2
        likeImg.addGestureRecognizer(tapOne)
        likeImg.isUserInteractionEnabled = true
        postImg.addGestureRecognizer(tapTwo)
        postImg.isUserInteractionEnabled = true
        
    }
    
    func configureCell(post: Post, image: UIImage? = nil) {
        
        self.post = post
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)

        self.caption.text = post.caption
        self.likesLbl.text = String(post.likes)
        
        if image != nil {
            self.postImg.image = image
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("EVGY: Unable to download the image from Firebase storage")
                } else {
                    print("EVGY: The imaged is downloaded form firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                    }
                }
            })
            
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
    }
    
}
