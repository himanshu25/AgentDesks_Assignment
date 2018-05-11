//
//  RadioListItemView.swift
//  CareUI
//
//  Created by Pavel Zhuravlev on 1/8/17.
//  Copyright © 2017 Care.com. All rights reserved.
//

import UIKit

@IBDesignable
public class RadioListItemView: ListItemView {
    
    public var selected: Bool? {
        didSet {
            if let radioLineItem = lineItem as? RadioLineItem,
                let selected = selected
            {
                radioLineItem.selected = selected
                var selectedImageName = "radio-filled"
                if radioLineItem.radioGroup.multiSelectionAllowed {
                    selectedImageName = "Checked"
                }
                rightIconImage = UIImage(named: selected ? selectedImageName : "unselected",
                                         in: Bundle(for: type(of: self)), compatibleWith: nil)
                self.setNeedsDisplay()
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        lineItem = RadioLineItem(title: titleText ?? "", radioGroup: RadioLineItem.RadioGroup(), selected: selected ?? false)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        lineItem = RadioLineItem(title: titleText ?? "", radioGroup: RadioLineItem.RadioGroup(), selected: selected ?? false)
            .with(leftIconImage: leftIconImage)
            .with(subTitle: subTitleText)
            .with(rightText: rightText)
            .with(disclosureHidden: isDisclosureHidden)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        rightIconImage = UIImage(named: (selected ?? false) ? "radio-filled" : "unselected",
                                 in: Bundle(for: type(of: self)), compatibleWith: nil)
    }
    
    @IBAction func selectedAction() {
        
    }
    
}
