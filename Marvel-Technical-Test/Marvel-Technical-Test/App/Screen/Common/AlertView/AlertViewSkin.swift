//
//  AlertViewSkin.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 20/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import UIKit
struct AlertViewSkin {
    
    let image: UIImage?
    let title: String?
    let body: String?
    let leftButton: (text: String?, skin: ButtonSkin, action: (() -> Void)?)?
    let rightButton: (text: String?, skin: ButtonSkin, action: (() -> Void)?)?
    
    fileprivate init(image: UIImage? = nil,
                     title: String? = nil,
                     body: String? = nil,
                     leftButton: (text: String?, skin: ButtonSkin, action: (() -> Void)?)? = nil,
                     rightButton: (text: String?, skin: ButtonSkin, action: (() -> Void)?)? = nil) {
        self.image = image
        self.title = title
        self.body = body
        self.leftButton = leftButton
        self.rightButton = rightButton
    }
    
    public static func question(text: String,
                                image: UIImage?,
                                afirmativeAction: (() -> Void)? = nil,
                                negativeAction: (() -> Void)? = nil) -> AlertViewSkin {
        return AlertViewSkin(image: image,
                              body: text,
                              leftButton: (text: R.text.cancel,
                                           skin: ButtonSkin.secundary,
                                           action: negativeAction),
                              rightButton: (text: R.text.accept,
                                            skin: ButtonSkin.main,
                                            action: afirmativeAction))
    }

    public static func warning(text: String, action: (() -> Void)? = nil) -> AlertViewSkin {
        return AlertViewSkin(image: nil,
                              body: text,
                              leftButton: (text: R.text.accept,
                                           skin: ButtonSkin.main,
                                           action: action))
        
    }
}
