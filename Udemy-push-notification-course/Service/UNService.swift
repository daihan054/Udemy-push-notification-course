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
