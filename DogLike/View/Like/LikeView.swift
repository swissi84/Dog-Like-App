
import Foundation
import SwiftUI


struct LikeView: View {
 
    
    @State private var dragOffset: CGSize = .zero
    @State private var showPlaceholder = false
   
    var notificationViewModel: NotificationManager
    var viewModel: DogViewModel
 
    
    init(notificationViewModel: NotificationManager, viewModel: DogViewModel) {
        self.notificationViewModel = notificationViewModel
        self.viewModel = viewModel
    }
    
    let animationDuration: Double = 0.25
 
    @State var isAnimating: Bool = false
    @State var shrinkIcon: Bool = false
    @State var floatLike: Bool = false
    @State var showFlare: Bool = false
    
    // MARK:- views
    var body: some View {
        VStack {
            HStack {
             ZStack {
                    if (floatLike) {
                        CapusuleGroupView(isAnimating: $floatLike)
                            .offset(y: -130)
                            .scaleEffect(self.showFlare ? 1.25 : 0.8)
                            .opacity(self.floatLike ? 1 : 0)
                            .animation(Animation.spring().delay(animationDuration / 2), value: animationDuration)
                    }
                    Circle()
                        .foregroundColor(self.isAnimating ? Color.likeColor : Color.likeOverlay)
                        .animation(Animation.easeOut(duration: animationDuration * 2).delay(animationDuration), value: animationDuration)
                    HeartImageView()
                        .foregroundColor(.white)
                        .offset(y: 12)
                        .scaleEffect(self.isAnimating ? 1.25 : 1)
                        .overlay(
                            Color.likeColor
                                .mask(
                                    HeartImageView()
                                )
                                .offset(y: 12)
                                .scaleEffect(self.isAnimating ? 1.35 : 0)
                                .animation(Animation.easeIn(duration: animationDuration), value: animationDuration)
                                .opacity(self.isAnimating ? 0 : 1)
                                .animation(Animation.easeIn(duration: animationDuration).delay(animationDuration), value: animationDuration)
                        )
                        .frame(width: 250, height: 250)
                        .scaleEffect(self.shrinkIcon ? 0.35 : 1)
                        .animation(Animation.spring(response: animationDuration, dampingFraction: 1, blendDuration: 1), value: animationDuration)
                    if (floatLike) {
                        FloatingLike(isAnimating: $floatLike)
                            .offset(y: -40)
                    }
                }.onTapGesture {
                    animateTransition(isLike: true)
//                    likeViewModel.lastScale = 1.0
//                    likeViewModel.scale = 1.0
                  
                    if (!floatLike) {
                        self.floatLike.toggle()
                        self.isAnimating.toggle()
                        self.shrinkIcon.toggle()
                        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
                            self.shrinkIcon.toggle()
                            self.showFlare.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 5) {
                            self.floatLike = false
                            self.isAnimating = false
                            self.shrinkIcon = false
                            self.showFlare = false
                        }
                    }
                }
            }
            .frame(width: 100)
        }
   
    }
   
    func animateTransition(isLike: Bool) {
      
        if isLike {
            viewModel.likeAction()
       
            
            print("likeAction")
        } else {
            viewModel.dislikeAction()
          
            print("dislikeAction")
        }
       
        notificationViewModel.mileStone()
        
        
    }
}


