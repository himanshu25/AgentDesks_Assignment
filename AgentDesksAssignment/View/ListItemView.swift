//
//  ListItemView.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

protocol ListItemViewDelegate: class {
    func listItemSelected(_ listItemView: ListItemView)
}

public class ListItemView: UIView {
    
    weak var delegate: ListItemViewDelegate?
    private var isSelected = false
    var vm: ViewModel!
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
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    public func setupUI() {
        rightIconImageView.image = nil
        leftIconImageView.image = nil
    }
    
    @IBAction func selected(_ sender: UIButton) {
        if isSelected {
            isSelected = false
            rightIconImageView.image = UIImage(named: "Empty Check")
        }
        else {
            isSelected = true
            delegate?.listItemSelected(self)
        }
    }
    
}
