//
//  FeedsTableViewCell.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 28..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Btn Actions
    @IBAction func touchLikeBtn(sender: AnyObject) {
        
    }
    
    @IBAction func touchCommentBtn(sender: AnyObject) {
        
    }
    
    @IBAction func touchMessageBtn(sender: AnyObject) {
        
    }
    
    
    
}
