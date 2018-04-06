//
//  UserListTableViewCell.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/5/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class UserListTableViewCell: UITableViewCell {

 
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHtmlUrl: UILabel!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUserPropertiesData(user: User) {
        
        activityIndicator.startAnimating()
        userIcon.sd_setImage(with: user.avatarUrl) { [weak self] (image, error, cache, url) in
            OperationQueue.main.addOperation {
                self?.activityIndicator.stopAnimating()
            }
        }
        userName.text = user.login
        userHtmlUrl.text = user.htmlUrl.absoluteString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userIcon.layer.cornerRadius = userIcon.bounds.height/2
        userIcon.clipsToBounds = true
        userIcon.layer.masksToBounds = true
        userIcon.layer.borderWidth = 1
        userIcon.layer.borderColor = UIColor.brown.cgColor
    }
}
