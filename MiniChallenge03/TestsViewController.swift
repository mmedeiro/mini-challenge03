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
    
    @IBOutlet weak var qst1: UILabel!
    @IBOutlet weak var qst2: UILabel!
    @IBOutlet weak var qst3: UILabel!
    @IBOutlet weak var qst4: UILabel!
    @IBOutlet weak var qst5: UILabel!
    
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
        
        
        
        
        let nav = self.navigationController?.navigationBar
        if let font = UIFont(name: "Palatino", size: 25) {
            nav?.titleTextAttributes = [NSFontAttributeName: font]
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TestsViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        self.navigationController!.interactivePopGestureRecognizer!.enabled = false
//        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBarHidden = false
        
    }
    
    func setLabelsAndAnswers(questions: [String],ansers: [String])
    {
        qst1.text = questions[0]
        qst2.text = questions[1]
        qst3.text = questions[2]
        qst4.text = questions[3]
        qst5.text = questions[4]
    }
    
    override func viewWillAppear(animated: Bool)
    {
        defineLayout = true
        pushView.frame = CGRectMake(0, self.view.frame.height - buttonView.frame.height, pushView.frame.width, pushView.frame.height)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let touch = touches.first! // as! UITouch
        lastPoint = touch.locationInView(self.view)
        
        if(isInsideDraw(lastPoint))
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
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first! // as! UITouch
        var currentPoint = touch.locationInView(self.view)
        
        if(isInside(currentPoint) || speedControl)
        {
//            pushView.frame = CGRectMake(pushView.frame.origin.x, currentPoint.y - 20, pushView.frame.width, pushView.frame.height)
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
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), .Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), .Normal)
            
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            
            self.tempDraw.image = UIGraphicsGetImageFromCurrentImageContext()
            self.tempDraw.alpha = opacity
            
            UIGraphicsEndImageContext()
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
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
            pushView.frame = CGRectMake(0, self.view.frame.height - buttonView.frame.height, pushView.frame.width, pushView.frame.height)
            
        }
        else
        {
            if(self.navigationController != nil)
            {
                self.pushView.frame.origin.y = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.height
            }
        }
    }
    
    func isInside(point: CGPoint) -> Bool
    {
        let rect = CGRectMake(pushView.frame.origin.x, pushView.frame.origin.y, buttonView.frame.width, buttonView.frame.height)
        return CGRectContainsPoint(rect, point)
    }
    
    func isInsideDraw(point: CGPoint) -> Bool
    {
        let rect = CGRectMake(mainDraw.frame.origin.x, mainDraw.frame.origin.y, mainDraw.frame.width, mainDraw.frame.height)
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
        brush = 5.0;
        opacity = 1.0;
        inBorracha = false
    }
    
    @IBAction func selectedEraser(sender: AnyObject)
    {
        red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 255.0/255.0;
        opacity = 1.0;
        brush = 10.0;
        inBorracha = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
