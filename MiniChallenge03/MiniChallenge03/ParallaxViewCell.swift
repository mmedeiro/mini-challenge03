//
//  ParallaxViewCell.swift
//  MiniChallenge03
//
//  Created by João Vitor dos Santos Schimmelpfeng on 20/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

let ImageHeight: CGFloat = 200.0
let OffsetSpeed: CGFloat = 25.0

class ParallaxViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    func offset(offset: CGPoint)
    {
        imageView.frame = CGRectOffset(self.imageView.bounds, offset.x, offset.y)
    }
}
