//
//  ListItemView.swift
//  CareUI
//
//  Created by Pavel Zhuravlev on 12/19/16.
//  Copyright © 2016 Care.com. All rights reserved.
//

import UIKit

protocol ListItemViewDelegate: class {
    func listItemSelected(_ listItemView: ListItemView)
}

public class ListItemView: UIView {
    
    var vm: ViewModel?
    weak var delegate: ListItemViewDelegate?
    public var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }

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
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
       // setupUI()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        // setupUI()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func setupUI() {
        if let vm = vm {
            if vm.icon.isEmpty {
                rightIconImageView.image = nil
                leftIconImageView.image = nil
                titleLabel.textColor = UIColor.black
            }
            else {
                leftIconImage = UIImage(named: vm.icon)
            }
            titleText = vm.name
        }
    }
    
    @IBAction func selected(_ sender: UIButton) {
        if !(vm?.icon.isEmpty)! {
            rightIconImageView.image = UIImage(named: "Radio Filled")
        }
        delegate?.listItemSelected(self)
    }
    
}
