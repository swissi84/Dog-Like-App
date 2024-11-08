import Foundation

protocol DogRepositoryProtocol {
    func fetchRandomDogImage() async throws -> URL 
}
