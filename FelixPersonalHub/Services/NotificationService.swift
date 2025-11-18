//
//  NotificationService.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import Foundation
import UserNotifications

class NotificationService: ObservableObject {
    static let shared = NotificationService()
    
    @Published var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    private init() {
        checkAuthorizationStatus()
    }
    
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = granted ? .authorized : .denied
                if granted {
                    self.scheduleDefaultReminders()
                }
                completion(granted)
            }
        }
    }
    
    func scheduleDefaultReminders() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        // Daily study reminder (respecting free times and excluded days)
        let studyContent = UNMutableNotificationContent()
        studyContent.title = "Time to Study"
        studyContent.body = "Don't forget your daily study session!"
        studyContent.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19 // Evening free time
        dateComponents.minute = 0
        
        let studyTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let studyRequest = UNNotificationRequest(
            identifier: "dailyStudyReminder",
            content: studyContent,
            trigger: studyTrigger
        )
        
        center.add(studyRequest)
    }
    
    func scheduleSleepReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Wind Down Time"
        content.body = "Time to prepare for sleep"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: "sleepReminder",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

