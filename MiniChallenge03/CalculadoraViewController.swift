 //
//  CalculadoraViewController.swift
//  MiniChallenge03
//
//  Created by Felipe Marques Ramos on 28/05/15.
//  Copyright (c) 2015 Mariana Medeiro. All rights reserved.
//

import UIKit

class CalculadoraViewController: UIViewController {
    
    @IBOutlet weak var saida: UILabel!
    var buffer = String()
    var op = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear(sender: UIButton) {
        saida.text = "0"
        buffer = ""
        op = ""
    }
    
    @IBAction func btnNumber(sender: UIButton) {
        if saida.text == "0"{
            saida.text = ""
        }
        saida.text = saida.text!.stringByAppendingString(sender.titleLabel!.text!)
        
    }
    

    @IBAction func doOperation(sender: UIButton) {
        buffer = saida.text!
        saida.text = "0";
        op = sender.titleLabel!.text!
    }
    
    @IBAction func result(sender: UIButton) {
        let num1 = (buffer as NSString).doubleValue
        let num2 = (saida.text! as NSString).doubleValue
        switch op{
        case "/":
            buffer = "\(num1/num2)"
            saida.text = buffer
            break
        case "X":
            buffer = "\(num1*num2)"
            saida.text = buffer
            break
        case "-":
            buffer = "\(num1-num2)"
            saida.text = buffer
            break
        case "+":
            buffer = "\(num1+num2)"
            saida.text = buffer
            break
        default:
            saida.text = "ERROR"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
