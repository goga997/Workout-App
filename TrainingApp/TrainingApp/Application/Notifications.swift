//
//  Notifications.swift
//  TrainingApp
//
//  Created by Grigore on 17.07.2023.
//

import UIKit
import UserNotifications

class Notifications: NSObject {
     
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options:  [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings {  settings in
//            print(settings)
        }
    }
    
    
    //Methods For Creating Notification
    func scheduledateNotification(date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = "WORKOUT"
        content.body = "Do not forget about gym, today!"
        content.sound = .default
        content.badge = 1
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var triggerDate = calendar.dateComponents([.year, .month, .day], from: date)
        triggerDate.hour = 11
        triggerDate.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        //now I have to pass all this ** to notificationCenter
        notificationCenter.add(request) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
}

extension Notifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound ])
        } else {
            completionHandler([.alert, .sound])
        }
    }
    
    //cand se apasa pe notificare si se deschide app-ul de ex sau view-u cu actiunea propriu-zisa
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0 
        notificationCenter.removeAllDeliveredNotifications()
    }
}
