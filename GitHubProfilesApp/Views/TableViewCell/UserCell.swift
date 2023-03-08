//
//  UserCell.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var typeIconImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
    }
}
