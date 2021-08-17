import Foundation

enum APIError: Error {
  case badPath
}

class APIClient {
  
  static let shared = APIClient()
  
  func loadTimeline(completion: @escaping (Result<Timeline, Error>) -> ()) {
    guard let path = Bundle.main.path(forResource: "timeline", ofType: "json") else {
      completion(.failure(APIError.badPath))
      return
    }
    
    loadFromFile(filePath: path) { result in
      completion(result)
    }
  }
}

private extension APIClient {
  /// Decodes a model object from the file at the given path
  func loadFromFile<Model: Decodable>(filePath: String, completion: @escaping (Result<Model, Error>) -> Void) {
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      
      let model = try decoder.decode(Model.self, from: data)
      completion(.success(model))
      
    } catch(let error) {
      completion(.failure(error))
    }
  }
}
