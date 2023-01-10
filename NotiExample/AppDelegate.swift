//
//  AppDelegate.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import UIKit
import FirebaseMessaging
import FirebaseCrashlytics
import Firebase
import UserNotifications
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var injectionContainer = NotiExampleDependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureFirebase()
        registerNotification(application)
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
    
    private func configureFirebase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
}

extension AppDelegate {
    
    private func registerNotification(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        Messaging.messaging().apnsToken = deviceToken
        print("token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Fail to receveied device token")
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userinfo = response.notification.request.content.userInfo
        let notiName = userinfo["NOTI_NAME"] as! String
        
        print("NotiName", notiName)
        
        let category = response.notification.request.content.categoryIdentifier
        if category == "MEETING_CATEGORY" {
            switch response.actionIdentifier {
            case "ACCEPT_ACTION":
                print("ACCEPT_ACTION")
                break
            case "DECLINE_ACTION":
                print("DECLINE_ACTION")
                break
            default:
                break
            }
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let category = notification.request.content.categoryIdentifier
        if category == "MEETING_CATEGORY" {
            //handle
        }
        completionHandler(.alert)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
         NotificationCenter.default.post(
           name: Notification.Name("FCMToken"),
           object: nil,
           userInfo: dataDict
         )
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

