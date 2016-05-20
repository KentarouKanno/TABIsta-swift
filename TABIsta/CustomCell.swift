//
//  CustomCell.swift
//  TABIsta
//
//  Created by System on 2016/05/16.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var title:UILabel!
    @IBOutlet var image:UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}