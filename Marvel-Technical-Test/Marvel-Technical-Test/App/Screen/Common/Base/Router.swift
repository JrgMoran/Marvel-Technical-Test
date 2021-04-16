//
//  Router.swift
//  Marvel-Technical-Test
//
//  Created by Jorge Morán on 04/08/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
import UIKit

enum RouterMode {
    case modal
    case push
    case form
    case new
}

class Router {
    
    var injector: DependencyInjector = DependencyInjector()
    
    deinit {
        print("- deinit: \(self)")
    }
    
    private var window: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.windows.first
        }
    }
    
    var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
    func navigate(to viewController: UIViewController, mode: RouterMode, animated: Bool = true){
        
        switch mode {
            // TODO: - Code
        case .modal:
            break;
        case .push: push(viewController: viewController, animated: animated)
        case .form:
            // TODO: - Code
            break;
        case .new:
            replace(viewController: viewController)
        }
        
    }
    
    func dismiss() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func presentTabBarController() {

    }
    
    func showAlert(skin: AlertViewSkin){
        
            let alertViewController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            
            let alertView = AlertView()
            alertView.skin = skin
            
            alertViewController.setValue(alertView, forKey: "contentViewController")
            rootViewController?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    private func push(viewController: UIViewController, animated: Bool = true) {
        if let navController = rootViewController as? UINavigationController ?? rootViewController?.navigationController {
            navController.pushViewController(viewController, animated: animated)
        
        } else {
            replace(viewController: viewController)
        }
    }
    
    private func replace(viewController: UIViewController){
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    
}
