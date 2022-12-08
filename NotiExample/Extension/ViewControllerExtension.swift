//
//  ViewControllerExtension.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func backAction() {
        if navigationController?.popViewController(animated: true) == nil {
            self.dismiss(animated: true)
        }
    }
    
    func navigateViewController(to viewController: UIViewController, modalPresentation: UIModalPresentationStyle = .formSheet) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            viewController.modalPresentationStyle = modalPresentationStyle
            self.present(viewController, animated: true)
        }
    }
}
