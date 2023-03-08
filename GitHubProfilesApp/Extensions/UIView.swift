//
//  UIView+Constraints+Extensions.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import UIKit

public enum ConstraintType {
    case top, bottom, leading, trailing, width, height, centerX, centerY
}

public typealias ConstraintInfo = [ConstraintType: NSLayoutConstraint]

extension UIView {
    
    @discardableResult
    public func alignWith(view: UIView, padding inset: UIEdgeInsets = .zero, activate: Bool = true) -> ConstraintInfo {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: ConstraintInfo = [.top: topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                                          .bottom: bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom),
                                          .leading: leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
                                          .trailing: trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.right)]
        defer { if activate { NSLayoutConstraint.activate(Array(constraint.values)) } }
        return constraint
    }
    
    @discardableResult
    public func alignCenterTo(view: UIView, activate: Bool = true) -> ConstraintInfo {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: ConstraintInfo = [.centerX: centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                          .centerY: centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        defer { if activate { NSLayoutConstraint.activate(Array(constraint.values)) } }
        return constraint
    }
    
    @discardableResult
    public func alignWithSuperView(inset: UIEdgeInsets = .zero, activate: Bool = true) -> ConstraintInfo {
        guard let superview = superview else { return [:] }
        return alignWith(view: superview, padding: inset, activate: activate)
    }
    
    @discardableResult
    public func alignCenterWithSuperView(activate: Bool = true) -> ConstraintInfo {
        guard let superview = superview else { return [:] }
        return alignCenterTo(view: superview, activate: activate)
    }
    
    @discardableResult
    public func align(width: CGFloat, height: CGFloat, activate: Bool = true) -> ConstraintInfo {
        let constraint: ConstraintInfo = [.width: widthAnchor.constraint(equalToConstant: width),
                                          .height: heightAnchor.constraint(equalToConstant: height)]
        defer { if activate { NSLayoutConstraint.activate(Array(constraint.values)) } }
        return constraint
    }
    
    @discardableResult
    func loadContentView() -> UIView {
        let nibName = type(of: self).description().components(separatedBy: ".").last ?? ""
        let contentView = (Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView) ?? UIView()
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": contentView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
        return contentView
    }
}
