//
//  BaseView.swift
//  DEWASmart
//
//  Created by Salman on 04/01/2022.
//  Copyright © 2022 DEWA. All rights reserved.
//

import UIKit

let bundle = Bundle(identifier: "Premani.SwipeButton")

public class BaseView: UIView, NibLoadable {
    var nibName: String!
    override init(frame: CGRect) {
        super.init(frame: frame)
      }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
}

protocol NibLoadable {
    var nibName: String! { get set }
}

extension NibLoadable where Self: BaseView {

    var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    func setupFromNib() {
        guard let view = nib.instantiate(withOwner: self, options: nil).last as? UIView else { fatalError("Error loading \(self) from nib") }
        addSubview(view)
        view.fillInSuperview()
    }
}
