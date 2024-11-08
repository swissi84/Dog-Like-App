





import SwiftUI

@main
struct DogLikeApp: App {
  
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
  
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                ContentView(notificationViewModel: NotificationManager(dogViewModel: DogViewModel()))
                   
                    .tabItem {
                        Label("Dogs", systemImage: "dog.fill")
                    }
                
                ProfilView(notificationViewModel: NotificationManager(dogViewModel: DogViewModel()), darmode: YinYangViewModel(), yinYanReset: YinToggleView())
                   
                    .tabItem {
                        Label("Meine Aufträge", systemImage: "person.circle.fill")
                    }
                
              
            }
        }
    }
}
