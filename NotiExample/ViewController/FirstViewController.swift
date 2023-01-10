//
//  FirstViewController.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 08/12/2022.
//

import UIKit
import UserNotifications

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
        registerActionableNotification()
        pushLocalNoti()
        pushLocalNotiDateTime()
    }
    
    private func pushLocalNotiDateTime() {
        var content = UNMutableNotificationContent()
        content.title = "Test noti date time"
        content.body = "Test noti trigger date time"
        
        var dateComponent = DateComponents()
        dateComponent.hour = 16
        dateComponent.minute = 05
        dateComponent.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            
        }
    }
    
    private func registerActionableNotification() {
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION", title: "Accept", options: [])
        
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION", title: "Decline", options: [])
        
        let meetingInviteCategory = UNNotificationCategory(identifier: "MEETING_CATEGORY", actions: [acceptAction, declineAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([meetingInviteCategory])
    }

    private func pushLocalNoti() {
        let content = UNMutableNotificationContent()
        content.body = "Hello"
        content.title = "Test Noti"
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "noti_sound.caf"))
        
        content.categoryIdentifier = "MEETING_CATEGORY"
        content.userInfo = [ "NOTI_NAME": "TEST NOTIFICATION"]
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print("error push noti \(error?.localizedDescription)")
            
        }
        
      //  UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuidString])

    }
    
    private func removeAllPendingNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    @IBAction func onClickedButton(_ sender: Any) {
        let secondViewController = factory.makeSecondViewController()
        self.navigateViewController(to: secondViewController)
    }
    
}
