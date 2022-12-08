//
//  FirstViewController.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import UIKit

protocol FirstViewControllerFactory {
    
    func makeSecondViewController() -> SecondViewController
}

class FirstViewController: UIViewController {
    
    var factory: FirstViewControllerFactory
    
    init(factory: FirstViewControllerFactory) {
        self.factory = factory
        super.init(nibName: "FirstViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickedButton(_ sender: Any) {
        let secondViewController = factory.makeSecondViewController()
        self.navigateViewController(to: secondViewController)
    }
    
}
