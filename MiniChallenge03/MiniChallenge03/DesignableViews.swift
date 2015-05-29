//
//  DesignableViews.swift
//  MiniChallenge03
//
//  Created by Mariana Medeiro on 29/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /* Extensão da classe UIView (serve para 
    UIButtons, UILabels, etc. 
    Permite mudar a largura e cor da borda e
    o cornerRadius pelo Interface Builder.
    */
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor)!
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

/* Permite ver as mudanças feitas pelo IB. */
@IBDesignable
class ABButton: UIButton {}