//
//  FirstViewDependencyContainer.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import Foundation

class FirstViewDependencyContainer {
    
    func makeFirstViewController() -> FirstViewController {
        return FirstViewController(factory: self)
    }
}

extension FirstViewDependencyContainer: FirstViewControllerFactory {
    
    func makeSecondViewController() -> SecondViewController {
        let secondViewController = makeSecondViewDependencyContainer().makeSecondViewController()
        return secondViewController
    }
    
    func makeSecondViewDependencyContainer() -> SecondViewDependencyContaier {
        return SecondViewDependencyContaier()
    }
}
