

import SwiftUI

@MainActor
struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
   
 
    
    @StateObject private var viewModel = DogViewModel()
    
    private var notificationViewModel: NotificationManager
  
    
    
    @State private var dragOffset: CGSize = .zero
    @State private var showPlaceholder = false
    @State private var imageKey = UUID()
    @State private var slideOut = false
    @State private var isBreedNameExpanded = false
    @State private var shakeOffset: CGFloat = 0
    @State private var isImageLoading = false
   
    @State var scale: CGFloat = 1.0
    @State var lastScale: CGFloat = 1.0
    

    

    init(notificationViewModel: NotificationManager) {
        self.notificationViewModel = notificationViewModel
        
    }
    
    var body: some View {
        VStack {
            
            Text(viewModel.breedName.replacingOccurrences(of: "-", with: " ").capitalized)
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .cornerRadius(10)
                .offset(x: shakeOffset)
                .animation(
                    Animation.interpolatingSpring(stiffness: 100, damping: 5)
                        .repeatForever(autoreverses: true),
                    value: shakeOffset
                )
                .scaleEffect(isBreedNameExpanded ? 1.5 : 1.0)
                .animation(.easeInOut(duration: 0.5), value: isBreedNameExpanded)
                .onTapGesture {
                    isBreedNameExpanded.toggle()
                    withAnimation {
                        shakeOffset = 10
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            shakeOffset = -10
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            shakeOffset = 0
                        }
                    }
                }
                .padding()
            
            HStack {
                Image(systemName: "arrow.left.circle")
                    .font(.title)
                Text("Swipe for DisLike")
                    .font(.title2)
            }
            .bold()
            
            Spacer()
            
            if viewModel.isImageLoading {
                SpinningView()
                    .cornerRadius(10)
                    .padding()
            } else if let dogImageURL = viewModel.dogImageURL {
                AsyncImage(url: dogImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .scaleEffect(scale)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                 
                                    scale = lastScale * value
                                }
                                .onEnded { value in
                                    lastScale = scale
                                }
                        )
                        .offset(x: dragOffset.width)
                        .opacity(1.0 - Double(abs(dragOffset.width) / 200))
                        .onTapGesture {
                            print("URL: \(viewModel.dogImageURL!)")
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    dragOffset = gesture.translation
                                    
                                }
                                .onEnded { _ in
                                    if dragOffset.width < -100 {
                                        viewModel.dislikeAction()
                                        notificationViewModel.mileStone()
                                        scale = 1.0
                                        lastScale = 1.0
                                    }
                                    dragOffset = .zero
                                    loadNextImage()
                                }
                        )
                        .transition(.move(edge: .trailing))
                        .id(imageKey)
                        .padding()
                    
                } placeholder: {
                    SpinningView()
                        .cornerRadius(10)
                        .padding()
                }
                .onChange(of: viewModel.dogImageURL) {
                    viewModel.isImageLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        imageKey = UUID()
                        viewModel.isImageLoading = false
                    }
                }
            } else {
                SpinningView()
                    .cornerRadius(10)
                    .padding()
            }
            
            Spacer()
            
            DogLike.LikeView(notificationViewModel: notificationViewModel, viewModel: viewModel)
                    .scaleEffect(0.3)
                    .frame(width: 50, height: 50)
               
           
                       
            .padding()
        }
        .onAppear {
            Task {
                try await notificationViewModel.requestAuthorisation()
                notificationViewModel.listScheduledNotifications()
           
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    private func loadNextImage() {
        
        isImageLoading = true
        viewModel.loadNextImage { success in
            
            isImageLoading = false
            
            if success {
                print("Bild erfolgreich geladen!")
            } else {
                print("Fehler beim Laden des Bildes")
            }
        }
        
    }
}

