//
//  CircleButton.swift
//  Scribe
//
//  Created by Andre Rosa on 27/07/17.
//  Copyright © 2017 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30{
        didSet{
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        layer.cornerRadius = cornerRadius
    }

}
