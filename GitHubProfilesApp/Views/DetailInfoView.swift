//
//  DetailInfoView.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import UIKit

class DetailInfoView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var disclosureIndicatorView: UIView!
    
    
    // MARK: - Data
    
    private var action: (() -> Void)?
    
    // MARK: - View
    
    init(title: String, text: String, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.loadContentView()
        self.titleLabel.text = title
        self.infoLabel.text = text
        self.action = action
        self.disclosureIndicatorView.isHidden = action == nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBOutlets Action
    
    @IBAction func viewDidTapped(_ sender: Any) {
        action?()
    }
}
