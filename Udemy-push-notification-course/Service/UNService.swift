//
//  UNService.swift
//  Udemy-push-notification-course
//
//  Created by REVE Systems on 11/5/23.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    static let shared = UNService()
    
    private override init() { }
    
    let unCenter = UNUserNotificationCenter.current()
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { granted, error in
            print(error ?? "No auth error")
            
            guard granted else {
                print("USER DENIED ACCESS")
                return
            }
            self.configure()
        }
    }
    
    func configure() {
        unCenter.delegate = self
    }
    
    func getAttachment(for id: NotificationAttachmentID) -> UNNotificationAttachment? {
        var imageName: String
        switch id {
        case .timer:
            imageName = "TimeAlert"
        case .date:
            imageName = "DateAlert"
        case .location:
            imageName = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
        
        do {
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
        } catch {
            return nil
        }
    }
    
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default
        content.badge = 1
        
        if let attachment = getAttachment(for: .timer) {
            content.attachments = [attachment]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        unCenter.add(request)
    }
    
    func dateRequest(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future!"
        content.sound = .default
        content.badge = 1
        
        if let attachment = getAttachment(for: .date) {
            content.attachments = [attachment]
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.date",
                                            content: content,
                                            trigger: trigger)
        unCenter.add(request)
        
    }
    
    func locationRequest() {
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "Welcome back!!"
        content.sound = .default
        content.badge = 1
        if let attachment = getAttachment(for: .location) {
            content.attachments = [attachment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        unCenter.add(request)
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
