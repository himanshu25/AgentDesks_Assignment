//
//  PopoverView.swift
//  CareUI
//
//  Created by Himanshu on 10/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol PopoverViewProtocol: class {
    @objc optional func primaryBtnPressed(sender: UIButton)
    @objc optional func secondaryBtnPressed(sender: UIButton)
}

public class PopoverView: UIView {
    
    @IBOutlet internal weak var headerLabel: UILabel?
    @IBOutlet internal weak var messageLabel: UILabel?
    @IBOutlet internal weak var primaryBtnView: UIView?
    @IBOutlet internal weak var secondaryBtnView: UIView?
    
    @IBOutlet internal weak var buttonsContainerStackView: UIStackView!
    @IBOutlet internal weak var primaryBtn: UIButton?
    @IBOutlet internal weak var secondaryBtn: UIButton?
    
    @IBOutlet internal weak var contentStackView: UIStackView?
    
    @IBOutlet weak var contentStackViewTopSpaceConstraint: NSLayoutConstraint?
    
    var delay: Double = 3.0
    private var duration = 0.3
    private let screenHeight = UIScreen.main.bounds.size.height
    private let screenWidth = UIScreen.main.bounds.size.width
    private var actionBlock: ((PopoverView) -> Void)?
    private var secondaryActionBlock: ((PopoverView) -> Void)?

    public weak var popoverViewDelegate: PopoverViewProtocol?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setupUI()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupUI()
    }
    
    public func onPrimaryClick(_ actionBlock: ((PopoverView) -> Void)? = nil) -> Self {
        self.actionBlock = actionBlock
        return self
    }
    
    public func onSecondaryClick(_ actionBlock: ((PopoverView) -> Void)? = nil) -> Self {
        self.secondaryActionBlock = actionBlock
        return self
    }
    
    public func with(messageTitle: String) -> Self {
        headerLabel?.text = messageTitle
        headerLabel?.isHidden = false
        return self
    }
    
    public func with(messageText: String) -> Self {
        messageLabel?.text = messageText
        messageLabel?.isHidden = false
        return self
    }
    
    public func with(primaryButtonTitle: String,
                     styleName: String? = nil, flexibleWidth: Bool? = nil,
                     do action: ((PopoverView) -> Void)? = nil) -> Self
    {
        primaryBtn?.setTitle(primaryButtonTitle, for: .normal)
        primaryBtnView?.isHidden = false
        primaryBtn?.isHidden = false
        primaryBtn?.layer.cornerRadius = 15
        primaryBtn?.layer.borderWidth = 2
        if let action = action {
            actionBlock = action
        }
        return self
    }
    
    public func with(secondaryButtonTitle: String) -> Self {
        secondaryBtn?.setTitle(secondaryButtonTitle, for: .normal)
        secondaryBtnView?.isHidden = false
        secondaryBtn?.isHidden = false
        secondaryBtn?.layer.cornerRadius = 15
        secondaryBtn?.layer.borderWidth = 2
        return self
    }
    
    /**
     * buttons are arranged horizontally by default, call this if you want to change arrangement to vertical
     */
    public func withButtonsArrangedVertically(makeTopButtonEqualWidth: Bool = false, makeBottomButtonEqualWidth: Bool = false) -> Self {
        buttonsContainerStackView.axis = .vertical
        
        if let primaryBtn = primaryBtn, let secondaryBtn = secondaryBtn {
            // you cannot make second button equal width with primary, and at the same time - primary equal width with secondary
            if makeTopButtonEqualWidth {
                secondaryBtn.widthAnchor.constraint(equalTo: primaryBtn.widthAnchor, multiplier: 1).isActive = true
            }
            else if makeBottomButtonEqualWidth {
                primaryBtn.widthAnchor.constraint(equalTo: secondaryBtn.widthAnchor, multiplier: 1).isActive = true
            }
        }
        
        return self
    }
    
    public func with(delegate: PopoverViewProtocol) -> Self {
        popoverViewDelegate = delegate
        return self
    }
    
    public func show(inView view: UIView? = nil, autoHide: Bool = false, after delay: Double = 0.5, dismissOnTap: Bool = true) {
        self.delay = delay
        
        if let view = view {
            view.addSubview(self)
            frame = CGRect(x: 0.0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height)
        }
        else {
            addWindowSubview(self)
        }
        
        if dismissOnTap {
            let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(hide))
            addGestureRecognizer(tapToDismiss)
        }
        
        frame.origin.y = 0
        contentStackViewTopSpaceConstraint?.constant = 20
        layoutIfNeeded()
        if autoHide {
            perform(#selector(hide), with: self, afterDelay: self.delay)
        }
    }
    
    @IBAction func primaryBtnPressed(_ sender: UIButton) {
        popoverViewDelegate?.primaryBtnPressed?(sender: sender)
        actionBlock?(self)
        hide()
    }
    
    @IBAction func secondaryBtnPresses(_ sender: UIButton) {
        popoverViewDelegate?.secondaryBtnPressed?(sender: sender)
        secondaryActionBlock?(self)
        hide()
    }
    
    @objc public func hide() {
        frame.origin.y = screenHeight
        
        // in case custom subview will be retained
        contentStackView?.arrangedSubviews.forEach { subView in
            contentStackView?.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
    
    internal func setupUI() {
        headerLabel?.isHidden = true
        messageLabel?.isHidden = true
        primaryBtnView?.isHidden = true
        secondaryBtnView?.isHidden = true
        primaryBtn?.isHidden = true
        secondaryBtn?.isHidden = true
    }
    
    private func addWindowSubview(_ view: UIView) {
        if self.superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.windowLevel == UIWindowLevelNormal
                    && !window.isHidden
                    && window.frame != .zero {
                    window.addSubview(view)
                    view.frame = CGRect(x: 0.0, y: self.screenHeight, width: self.screenWidth, height: self.screenHeight)
                    return
                }
            }
        }
    }
}
