//
//  ListItemTableViewCell.swift
//  CareUI
//
//  Created by Pavel Zhuravlev on 12/20/16.
//  Copyright © 2016 Care.com. All rights reserved.
//

import UIKit

public class ListItemTableViewCell: UITableViewCell {
    
    public private(set) var listItemView: ListItemView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func configure() {
        listItemView?.layoutIfNeeded()
    }
    
//    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        contentView.backgroundColor = UIColor.white
//    }
//    
//    override public func setSelected(_ selected: Bool, animated: Bool) {
//        contentView.backgroundColor = UIColor.white
//    }

    private func setupUI() {
        self.listItemView = ListItemView()
        contentView.addSubview(listItemView!)
    }
    
}
