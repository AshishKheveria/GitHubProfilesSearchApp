//
//  LoadingView.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        loadContentView()
        isHidden = true
        activityIndicator.hidesWhenStopped = true
    }

    // MARK: - Public Methods

    public func showMessage(_ message: String,
                            animateLoader: Bool,
                            autoHide after: TimeInterval? = nil) {
        
        self.isHidden = false
        
        statusLabel.text = message
        animateLoader ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
        if let timeInterval = after {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) { [weak self] in
                self?.hide()
            }
        }
    }
    
    public func hide() {
        self.isHidden = true
        statusLabel.text = nil
        activityIndicator.stopAnimating()
    }
}
