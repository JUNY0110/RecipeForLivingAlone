//
//  UIViewController+Extension.swift
//  PleaseRecipe
//
//  Created by 지준용 on 11/9/23.
//

import UIKit

extension UIViewController {
    private var windowScene: UIWindowScene? {
        var parent = self.parent
        var lastParent: UIViewController?
        
        while parent != nil {
            lastParent = parent
            parent = parent?.parent
        }
        
        return lastParent?.view.window?.windowScene
    }
    
    var statusBarFrame: CGRect? {
        windowScene?.statusBarManager?.statusBarFrame
    }
    
    var screenWidth: CGFloat? {
        windowScene?.screen.bounds.width
    }
    
    var screenHeight: CGFloat? {
        windowScene?.screen.bounds.height
    }
}
