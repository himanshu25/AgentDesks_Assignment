//
//  ListLineItem.swift
//  CareUI
//
//  Created by Pavel Zhuravlev on 12/19/16.
//  Copyright © 2016 Care.com. All rights reserved.
//

import UIKit

public enum ListLineItemBorder {
    case NoBorder
    case BorderOnePixel
    case BorderFourPixel
}

public protocol StatefulListLineItem {
    var selected: Bool { get }
}

open class ListLineItem: NSObject {
    
    public var leftIconImage: UIImage?
    public var leftIconImageWidth: CGFloat?
    
    public var titleText: String?
    public var titleTextColor: UIColor?
    public var subTitleText: String?
    public var subTitleTextColor: UIColor?
    public var subTitleAtTheBottom = false
    
    public var rightText: String?
    
    public var rightIconImage: UIImage?
    public var disclosureHidden = true
    public var shouldStrikeRightText = false // Should change all String to Attributed String 
    public var tag: Int?
    public var tagString: String?

    // careful about these members, not to create retain cycles
    internal weak var navigationItemsList: NavigationItemsList?
    public var isSubListItem = false
    
    public var actionBlock: ((ListLineItem) -> Void)?
    public var borderType: ListLineItemBorder?

    public var styleName: String?

    public override init() {
        super.init()
    }
    
    deinit {
        navigationItemsList = nil
    }
    
    public func select(withCell cell: UITableViewCell? = nil) {
        actionBlock?(self)
    }

    public func with(itemsList: NavigationItemsList) -> Self {
        self.navigationItemsList = itemsList
        return self
    }

    public func with(leftIconImage: UIImage?, width: CGFloat? = nil) -> Self {
        self.leftIconImage = leftIconImage
        self.leftIconImageWidth = width
        return self
    }
    
    public func with(title: String) -> Self {
        self.titleText = title
        return self
    }
    
    public func with(titleColor: UIColor) -> Self {
        self.titleTextColor = titleColor
        return self
    }
    
    public func with(subTitle: String?) -> Self {
        self.subTitleText = subTitle
        return self
    }
    
    public func with(rightText: String?) -> Self {
        self.rightText = rightText
        return self
    }
    
    public func with(rightIconImage: UIImage?) -> Self {
        self.rightIconImage = rightIconImage
        return self
    }
    
    public func with(disclosureHidden: Bool) -> Self {
        self.disclosureHidden = disclosureHidden
        return self
    }
    
    public func with(tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    public func with(tagString: String) -> Self {
        self.tagString = tagString
        return self
    }
    
    public func with(borderType: ListLineItemBorder) -> Self {
        self.borderType = borderType
        return self
    }

    public func with(styleName: String) -> Self {
        self.styleName = styleName
        return self
    }

    public func inSubList() -> Self {
        self.isSubListItem = true
        return self
    }
    
    public func onSelection(_ actionBlock: ((ListLineItem) -> Void)? = nil) -> Self {
        self.actionBlock = actionBlock
        return self
    }
    
    internal func reloadSelf() {
        navigationItemsList?.reload(item: self)
    }
    
//    public func reloadItem() {
//        self.reloadSelf()
//    }
}
