//
//  InicioCelulares.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 28/06/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import Foundation
import SwiftyJSON

struct InicioCelulares: Any {
 
    let name : String
    let categoria: String
    let rating: String
    let priceNow: String
    
    struct CelularesJSONKeys {
        static let name = "name"
        static let categoria = "categoria"
        static let rating = "rating"
        static let priceNow = "priceNow"
    }
    
    init(json: JSON) {
        self.name = json[CelularesJSONKeys.name].stringValue
        self.categoria = json[CelularesJSONKeys.categoria].stringValue
        self.rating = json[CelularesJSONKeys.rating].stringValue
        self.priceNow = json[CelularesJSONKeys.priceNow].stringValue
    }
    
    func simpleDescription(){
        print(self.name,self.categoria,self.rating,self.priceNow)
    }
    
    
}

