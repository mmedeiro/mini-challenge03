//
//  headerReusableView.swift
//  MiniChallenge03
//
//  Created by João Vitor dos Santos Schimmelpfeng on 21/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

class headerReusableView: UICollectionReusableView
{
    @IBOutlet weak var background: UIImageView!
    var initialFrame: CGRect!
    
    func setContentOffset(point: CGPoint)
    {
        self.frame = CGRectMake(0, point.y, self.frame.width , initialFrame.height + (point.y * -1))
        //background.frame = CGRectOffset(self.background.bounds, point.x, point.y)
    }
    
    func returnToContent()
    {
        self.frame = initialFrame
    }
}
