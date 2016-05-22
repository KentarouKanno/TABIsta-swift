//
//  UIButton+Extension.swift
//  TABIsta
//
//  Created by KentarOu on 2016/05/21.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    func setButtonImage(normal: UIImage?, selected: UIImage?) {
        self.setImage(selected, forState: .Selected)
        self.setImage(normal, forState: .Normal)
    }
}