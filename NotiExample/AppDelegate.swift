//
//  AppDelegate.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var injectionContainer = NotiExampleDependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    
    func goToViewController() {
        let firstViewController = injectionContainer.makeFirstViewController()
      
        if #available(iOS 13.0, *) {
            guard let windowScence = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScence.delegate as? SceneDelegate,
                  let window = sceneDelegate.window else { return }
            window.rootViewController = firstViewController
            window.makeKeyAndVisible()
            self.window = window
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = firstViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func goToSecondViewController() {
        let secondViewController = injectionContainer.makeSecondViewController()
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let scenceDelegate = windowScene.delegate as? SceneDelegate,
                  let window = scenceDelegate.window else {
                return
            }
            window.rootViewController = secondViewController
            window.makeKeyAndVisible()
            self.window = window
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = secondViewController
            self.window?.makeKeyAndVisible()
        }
    }
}

