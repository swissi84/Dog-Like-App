
import SwiftUI
import UIKit



class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "RETURN_ACTION":
            
            print("User chose to return.")
            
        case "IGNORE_ACTION":
            
            print("User chose to ignore the notification.")
            
        default:
            break
        }
        
        completionHandler()
    }
    
    // Überschreibt das Standard-Verhalten von iOS und sorgt dafür, dass die Benachrichtigungen auch angezeigt werden, wenn die App geöffnet ist
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.banner]
    }
}
//    
//    
//    
//    @UIApplicationMain
//    class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//            // Override point for customization after application launch.
//            return true
//        }
//
//        // MARK: UISceneSession Lifecycle
//
//        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//            // Called when a new scene session is being created.
//            // Use this method to select a configuration to create the new scene with.
//            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//        }
//
//        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//            // Called when the user discards a scene session.
//            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//        }
//
//
//    }
//    
//    
//}
//import SwiftUI
//import UIKit
//
//// AppDelegate class definition
//class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//    // Set up the NotificationCenter delegate to handle notification actions
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        UNUserNotificationCenter.current().delegate = self
//        return true
//    }
//    
//    // Handle notification action responses
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        
//        switch response.actionIdentifier {
//        case "RETURN_ACTION":
//            print("User chose to return.")
//            
//        case "IGNORE_ACTION":
//            print("User chose to ignore the notification.")
//            
//        default:
//            break
//        }
//        
//        completionHandler()
//    }
//    
//    // Display notifications as banners even when the app is in the foreground
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
//        [.banner]
//    }
//}

//// Main SwiftUI App structure
//@main
//struct MyApp: App {
//    // Set up the AppDelegate
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
