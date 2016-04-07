//
//  JsonManager.swift
//  MiniChallenge03
//
//  Created by Felipe Ramos on 4/6/16.
//  Copyright © 2016 Mariana Medeiro. All rights reserved.
//

import Foundation

class JsonManager: NSObject {

    static let sharedInstance = JsonManager();
    
    private override init(){
        super.init();
    }
    
    func lerMaterias()->[NSDictionary]{
        let jsonData = readJson("Materias") as! [String:Array<NSDictionary>]
        return jsonData["materias"]!
    }
    
    func lerConteudo(materia:String) -> [[String:Array<NSDictionary>] ] {
        let conteudo = readJson(materia) as! [String:Array<NSDictionary>]
        return conteudo.first!.1 as! [[String:Array<NSDictionary>] ]
    }
    
    
    private func readJson(nome:String)->AnyObject{
        let path = NSBundle.mainBundle().pathForResource(nome, ofType: "json")
        let data = try? NSData(contentsOfFile: path!, options: .DataReadingMapped)
        return try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
        
    }
}
