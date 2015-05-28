//
//  testsViewController.swift
//  MiniChallenge03
//
//  Created by João Vitor dos Santos Schimmelpfeng on 25/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

class TestsViewController: UIViewController {

    @IBOutlet weak var pushView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var mainDraw: UIImageView!
    @IBOutlet weak var tempDraw: UIImageView!
    
    @IBOutlet weak var buttonEraser: UIButton!
    @IBOutlet weak var buttonPencil: UIButton!
    
    var lastPoint : CGPoint!
    var red : CGFloat!
    var green : CGFloat!
    var blue :CGFloat!
    var brush: CGFloat!
    var opacity: CGFloat!
    
    @IBOutlet weak var labelBar: UILabel!
    
    var inBorracha = false
    
    var speedControl = false
    var defineLayout = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        red = 0.0/255.0;
        green = 0.0/255.0;
        blue = 0.0/255.0;
        brush = 5.0;
        opacity = 1.0;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        defineLayout = true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        var touch = touches.first as! UITouch
        var lastPoint = touch.locationInView(self.view)
        
        if(!isInside(lastPoint))
        {
            self.lastPoint = touch.locationInView(mainDraw)
            UIGraphicsBeginImageContext(mainDraw.frame.size)
            self.mainDraw.image?.drawInRect(CGRectMake(0, 0, mainDraw.frame.size.width, mainDraw.frame.size.height))
            self.tempDraw.image?.drawInRect(CGRectMake(0, 0, mainDraw.frame.size.width, mainDraw.frame.size.height))
            
            self.mainDraw.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        else
        {
         defineLayout = false
        }

    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        var touch = touches.first as! UITouch
        var currentPoint = touch.locationInView(self.view)
        
        if(isInside(currentPoint) || speedControl)
        {
            pushView.frame = CGRectMake(pushView.frame.origin.x, currentPoint.y - 20, pushView.frame.width, pushView.frame.height)
            speedControl = true
            
            return
        }
        
        if(isInsideDraw(currentPoint))
        {
            currentPoint = touch.locationInView(mainDraw)
            
            UIGraphicsBeginImageContext(mainDraw.frame.size)
            
            self.tempDraw.image?.drawInRect(CGRectMake(0, 0, mainDraw.frame.size.width, mainDraw.frame.size.height))
            
            
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
            
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            
            self.tempDraw.image = UIGraphicsGetImageFromCurrentImageContext()
            self.tempDraw.alpha = opacity
            
            
            UIGraphicsEndImageContext()
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        speedControl = false
        
        if(pushView.frame.origin.y < 200)
        {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.pushView.frame.origin.y = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.height
                
            })
        }
        else
        {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.pushView.frame.origin.y = self.view.frame.height - self.buttonView.frame.height
                
            })
        }

    }
    
    override func viewDidLayoutSubviews()
    {
        if(defineLayout)
        {
            pushView.frame = CGRectMake(0, self.view.frame.height - buttonView.frame.height, self.view.frame.width, self.view.frame.height + 100)
        }
    }
    
    func isInside(point: CGPoint) -> Bool
    {
        var rect = CGRectMake(pushView.frame.origin.x, pushView.frame.origin.y, buttonView.frame.width, buttonView.frame.height)
        return CGRectContainsPoint(rect, point)
    }
    
    func isInsideDraw(point: CGPoint) -> Bool
    {
        var rect = CGRectMake(mainDraw.frame.origin.x, mainDraw.frame.origin.y, mainDraw.frame.width, mainDraw.frame.height)
        return CGRectContainsPoint(rect, point)
    }
    
    func rotated()
    {
        defineLayout = true
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.pushView.frame.origin.y = self.view.frame.height - self.buttonView.frame.height
            
        })
    }
    
    
    @IBAction func selectedPen(sender: AnyObject)
    {
        red = 0.0/255.0;
        green = 0.0/255.0;
        blue = 0.0/255.0;
        brush = 10.0;
        opacity = 1.0;
        inBorracha = false
    }
    
    @IBAction func selectedEraser(sender: AnyObject)
    {
        red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 255.0/255.0;
        opacity = 1.0;
        inBorracha = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
