//
//  ListItemTableViewCell.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//


import UIKit

protocol ListItemCellDelegate: class {
    func listItemCellSelected(_ listItemViewCell: ListItemTableViewCell)
}

public class ListItemTableViewCell: UITableViewCell, ListItemViewDelegate {
    
    @IBOutlet weak var listItemView: ListItemView!
    weak var delegate: ListItemCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       // setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
         // setupUI()
    }

    public func setupUI() {
        listItemView.delegate = self
        listItemView.setupUI()
        contentView.addSubview(listItemView!)
    }
    
    func listItemSelected(_ listItemView: ListItemView) {
        delegate?.listItemCellSelected(self)
    }
    
}
