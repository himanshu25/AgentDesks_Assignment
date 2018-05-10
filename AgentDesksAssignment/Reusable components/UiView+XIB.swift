//
//  UiView+XIB.swift
//  Assignment
//
//  Created by Himanshu on 10/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

public extension UIView {
    
    @discardableResult public func loadNib(named nibName: String? = nil, bundle : Bundle? = nil) -> UIView? {
        let nib = UINib(nibName: nibName ?? String(describing: type(of: self)), bundle: bundle ?? Bundle(for: type(of: self)))
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
            return view
        }
        return nil
}
}
