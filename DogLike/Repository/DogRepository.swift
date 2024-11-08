import Foundation

class DogRepository: DogRepositoryProtocol {
    
    func fetchRandomDogImage() async throws -> URL {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let dogResponse = try JSONDecoder().decode(DogResponse.self, from: data)
        guard let imageUrl = URL(string: dogResponse.message) else {
            throw HTTPError.invalidImageURL
        }
        return imageUrl
    }
}

enum HTTPError: Error {
    case invalidURL, invalidImageURL
}
