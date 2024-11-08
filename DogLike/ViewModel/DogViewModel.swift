

import Foundation
import UserNotifications
import SwiftUI

@MainActor
class DogViewModel: ObservableObject {
    @Published var dogImageURL: URL?
    @Published var breedName = ""
    @Published var isImageLoading = false
    
    @AppStorage("likeCount") var likeCount: Int = 0
    @AppStorage("dislikeCount") var dislikeCount: Int = 0
    
    private var repository: DogRepositoryProtocol
    
    init(repository: DogRepositoryProtocol = DogRepository()) {
        self.repository = repository
        loadNextImage { _ in }
    }
    
 
    func loadNextImage(completion: @escaping (Bool) -> Void) {
        isImageLoading = true
        fetchRandomDogImage { url in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dogImageURL = url
                completion(url != nil)
                self.isImageLoading = false
            }
        }
    }
    

    func likeAction() {
        likeCount += 1
        loadNextImage { _ in }
    }

    func dislikeAction() {
        dislikeCount += 1
        loadNextImage { _ in }
    }
    
  
    private func fetchRandomDogImage(completion: @escaping (URL?) -> Void) {
        Task {
            do {
                let url = try await repository.fetchRandomDogImage()
                if let breedName = extractBreedName(from: url.absoluteString) {
                    self.breedName = breedName
                } else {
                    self.breedName = "No Breed found"
                }
                completion(url) 
            } catch {
                print("Error while loading: \(error)")
                completion(nil)
            }
        }
    }
    
  
    func extractBreedName(from urlString: String) -> String? {
        let searchKeyword = "breeds/"
        guard let range = urlString.range(of: searchKeyword) else {
            return nil
        }
        
        let substringFromBreed = urlString[range.upperBound...]
        var breed = ""
        for char in substringFromBreed {
            if char == "/" { break }
            breed.append(char)
        }
        
        return breed.isEmpty ? nil : breed
    }
    
   
    func greeting(name: String) -> String {
        return "Welcome to DogLike, \(name)!"
    }
}
