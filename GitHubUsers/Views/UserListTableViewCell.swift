//
//  UserListTableViewCell.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/5/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {

 
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHtmlUrl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUserPropertiesData(user: User) {
        userIcon.sd_setImage(with: user.avatarUrl, completed: nil)
        userName.text = user.login
        userHtmlUrl.text = user.htmlUrl.absoluteString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userIcon.layer.cornerRadius = userIcon.bounds.height/2
        userIcon.clipsToBounds = true
        userIcon.layer.masksToBounds = true
    }
}
