//
//  NotiExampleDependencyContainer.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import Foundation
import UIKit

class NotiExampleDependencyContainer {
    
    
    func makeFirstViewController() -> UINavigationController {
        let firstViewController = makeFirstViewDependencyContainer().makeFirstViewController()
        let navigationController = UINavigationController(rootViewController: firstViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    func makeFirstViewDependencyContainer() -> FirstViewDependencyContainer {
        return FirstViewDependencyContainer()
    }
    
    func makeSecondViewController() -> UINavigationController {
        let secondViewController = SecondViewController()
        let navigationController = UINavigationController(rootViewController: secondViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
