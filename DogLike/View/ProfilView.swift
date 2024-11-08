

import SwiftUI

struct ProfilView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    private var notificationViewModel: NotificationManager
    private var darkmode : YinYangViewModel
    private var yinYanReset : YinToggleView
    
    init(notificationViewModel: NotificationManager, darmode: YinYangViewModel, yinYanReset: YinToggleView) {
        self.notificationViewModel = notificationViewModel
        self.darkmode = darmode
        self.yinYanReset = yinYanReset
    }
    
    var body: some View {
        VStack {
         
          Text("Enable Darkmode")
                .font(.title)
                .bold()
                .padding(.vertical, 100)
            VStack(spacing: 50) {
                YinYangAnimationView()
                    .scaleEffect(0.9)
            }
            Spacer()
           
            Button(action: {
                notificationViewModel.scheduleNotification()
            }) {
                HStack(spacing: 24){
                    Image(systemName: "bell")
                        .resizable()
                        .scaledToFit()
                    Text("Werde benachrichtigt")
                        .bold()
                }
                .frame(width: 240, height: 32)
                .padding()
                .background(.pink)
                .foregroundStyle(.white)
                .cornerRadius(24)
            }
            
            Button(action: {
                notificationViewModel.scheduleNotificationDay()
            }) {
                HStack(spacing: 24){
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                    Text("Starte Erinnerung")
                        .bold()
                }
                .frame(width: 240, height: 32)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(24)
            }
            Spacer()
            .onAppear {
                Task {
                    try await notificationViewModel.requestAuthorisation()
                    notificationViewModel.listScheduledNotifications()
                    
                }
            }
            .padding()
       
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}


