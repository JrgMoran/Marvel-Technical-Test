//
//  Colors+Extensions.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 15/08/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
    return red
    */
    class var main: UIColor {
        return UIColor.red
    }
    
    /**
     return grey color (150 172 173)
    */
    class var unselected: UIColor {
        return UIColor(red: 148/255, green: 170/255, blue: 171/255, alpha: 1)
    }
    
    class var grayClear: UIColor {
        return UIColor.lightGray.withAlphaComponent(0.7)
    }
    
}
