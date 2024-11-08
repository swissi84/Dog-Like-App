//
//  NotificationManager.swift
//  DogLike
//
//  Created by Eggenschwiler Andre on 05.11.24.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager: ObservableObject {
    @AppStorage("likeCount") var likeCount: Int = 0
    @AppStorage("dislikeCount") var dislikeCount: Int = 0
    
    
    private let unCenter = UNUserNotificationCenter.current()
    private var dogViewModel: DogViewModel
    
    init(dogViewModel: DogViewModel) {
        self.dogViewModel = dogViewModel
    }
    
    
    func requestAuthorisation() async throws {
        
        let granted = try await unCenter.requestAuthorization(options: [.alert, .badge, .sound])
        
        if granted {
            print("Acces grandet!")
            dailyNothification()
            return
        } else {
            print("Acces not grandet!")
            return
        }
        
    }
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test"
        content.body = "Test"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        unCenter.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    
    func scheduleNotificationDay() {
        let content = UNMutableNotificationContent()
        var date = DateComponents()
        date.hour = 10
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        unCenter.add(request) { error in
            if let error = error {
                print("Failed to Day notification: \(error.localizedDescription)")
            } else {
                print("Day Notification successfully")
            }
        }
    }
    
    
    @MainActor
    func mileStone() {
        let count = dogViewModel.dislikeCount + dogViewModel.likeCount
        
        if count > 0 && count % 10 == 0 {
            let content = UNMutableNotificationContent()
            content.title = "Milestone Reached!"
            content.body = "You have evaluated \(count) Dogs!"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            unCenter.add(request) { error in
                if let error = error {
                    print("Failed to schedule notification: \(error)")
                } else {
                    print("Notification scheduled successfully for \(count) interactions")
                }
            }
        }
    }
    
    
    func listScheduledNotifications() {
        unCenter.getPendingNotificationRequests { notifications in
            print("Pending notifications: \(notifications.count)")
            
            for notification in notifications {
                print("Notification \(String(describing: notification.trigger))")
            }
        }
    }
    

    func setupNotificationActions() {
        let returnAction = UNNotificationAction(identifier: "RETURN_ACTION",
                                                title: "Return",
                                                options: [.foreground])
        let ignoreAction = UNNotificationAction(identifier: "IGNORE_ACTION",
                                                title: "Ignore",
                                                options: [])
        
        
        let notificationCategory = UNNotificationCategory(identifier: "ACTION_CATEGORY",
                                                          actions: [returnAction, ignoreAction],
                                                          intentIdentifiers: [],
                                                          options: .customDismissAction)
        
      
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([notificationCategory])
    }
    
   
    
    func dailyNothification() {
        let returnAction = UNNotificationAction(identifier: "RETURN_ACTION",
                                                title: "Return",
                                                options: [.foreground])
        let ignoreAction = UNNotificationAction(identifier: "IGNORE_ACTION",
                                                title: "Ignore",
                                                options: [])
        
        
        _ = UNNotificationCategory(identifier: "ACTION_CATEGORY",
                                                          actions: [returnAction, ignoreAction],
                                                          intentIdentifiers: [],
                                                          options: .customDismissAction)
        
      
        let content = UNMutableNotificationContent()
        content.title = "Daily Notification Dogs Like"
        content.body = "Dont forget to Like Dogs Today."
        content.categoryIdentifier = "ACTION_CATEGORY" 
        
        
        var dateComponents = DateComponents()
            dateComponents.hour = 9
            dateComponents.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}
    


