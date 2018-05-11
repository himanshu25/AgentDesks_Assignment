//
//  ListItemView.swift
//  CareUI
//
//  Created by Pavel Zhuravlev on 12/19/16.
//  Copyright © 2016 Care.com. All rights reserved.
//

import UIKit

@IBDesignable
public class ListItemView: UIView {
    
    @IBInspectable
    public var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    @IBInspectable
    public var subTitleText: String? = nil {
        didSet {
            if let subTitleText = subTitleText {
                subTitleLabel.text = subTitleText
                subTitleBottomLabel.text = subTitleText
            }
            else {
                subTitleLabel.isHidden = true
                subTitleBottomLabel.isHidden = true
            }
        }
    }
    
    @IBInspectable
    public var subTitleTextColor: UIColor? = nil {
        didSet {
            if let subTitleTextColor = subTitleTextColor {
                subTitleLabel.textColor = subTitleTextColor
                subTitleBottomLabel.textColor = subTitleTextColor
            }
        }
    }

    public var subTitleAtTheBottom: Bool = false {
        didSet {
            subTitleLabel.isHidden = subTitleAtTheBottom
            subTitleBottomLabel.isHidden = !subTitleAtTheBottom
        }
    }
    
    @IBInspectable
    public var leftIconImage: UIImage? {
        didSet {
            if let leftIconImage = leftIconImage {
                leftIconImageView.image = leftIconImage
                leftIconImageView.isHidden = false
            }
            else {
                leftIconImageView.isHidden = true
            }
        }
    }
    
    @IBInspectable
    public var rightText: String? = nil {
        didSet {
            if let rightText = rightText {
                rightTextLabel.text = rightText
                rightTextLabel.isHidden = false
                rightIconImageView.isHidden = true
            }
            else {
                rightTextLabel.isHidden = false
                rightIconImageView.isHidden = true
            }
        }
    }
    
    @IBInspectable
    public var rightIconImage: UIImage? {
        didSet {
            if let rightIconImage = rightIconImage {
                rightIconImageView.image = rightIconImage
                rightIconImageView.isHidden = false
                rightIconImageView.superview?.isHidden = false
                rightTextLabel.isHidden = true
                rightIconImageIsSet = true
            }
            else {
                rightIconImageView.superview?.isHidden = true
                rightTextLabel.isHidden = false
                rightIconImageView.isHidden = true
            }
        }
    }
    private var rightIconImageIsSet = false
    
    @IBInspectable
    public var isDisclosureHidden: Bool = true {
        didSet {
            disclosureImageView.isHidden = isDisclosureHidden
        }
    }
    
    @IBInspectable
    public var isSeparatorHidden: Bool = true {
        didSet {
            separatorView.isHidden = isSeparatorHidden
        }
    }
    
    @IBOutlet private weak var leftIconImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var subTitleBottomLabel: UILabel!
    
    @IBOutlet private weak var rightTextLabel: UILabel!
    @IBOutlet internal weak var rightIconImageView: UIImageView!
    @IBOutlet private weak var disclosureImageView: UIImageView!
    
    @IBOutlet private weak var separatorView: UIView!
    
    @IBOutlet private weak var contentLeftOffsetConstraint: NSLayoutConstraint!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupUI()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = titleText
        subTitleLabel.text = subTitleText
        subTitleBottomLabel.text = subTitleText
        subTitleAtTheBottom = true
        if let leftIconImage = leftIconImage {
            leftIconImageView.image = leftIconImage
        }
        else {
            leftIconImageView.isHidden = true
        }
        if let rightText = rightText {
            rightTextLabel.text = rightText
            rightTextLabel.isHidden = false
            rightIconImageView.isHidden = true
        }
        else {
            rightTextLabel.isHidden = true
            rightIconImageView.isHidden = true
        }
        if let rightIconImage = rightIconImage {
            rightIconImageView.image = rightIconImage
            rightIconImageView.isHidden = false
            rightTextLabel.isHidden = true
        }
        else {
            rightTextLabel.isHidden = false
            rightIconImageView.isHidden = true
            rightIconImageView.superview?.isHidden = true
        }
        disclosureImageView.isHidden = isDisclosureHidden
        separatorView.isHidden = true
    }
}
