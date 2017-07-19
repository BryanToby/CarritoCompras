//
//  CustomTextField.swift
//  CelularesPeru
//
//  Created by Bryan Lazaro Cusihuamán on 9/07/17.
//  Copyright © 2017 Bryan Lazaro Cusihuamán. All rights reserved.
//

import UIKit

class CustomTextField: UIView {
    
    func createBaseLine(_ mView: UITextField,r: Float, g: Float, b: Float, aBl: Float, an: Float) {
        let baseLine = UIView()
        baseLine.backgroundColor = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        baseLine.frame = CGRect(x: 0, y: CGFloat(aBl) , width: CGFloat(an), height: 1)
        mView.addSubview(baseLine)
        
    }
    
}
