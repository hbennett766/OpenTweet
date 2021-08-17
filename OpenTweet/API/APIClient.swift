import UIKit

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
  
  func loadAvatar(from url: URL, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
    return loadImage(from: url) { image in
      completion(image)
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
  
  /// Loads image from url
  func loadImage(from url: URL, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      DispatchQueue.main.async {
        
        guard let data = data, error == nil else {
          completion(nil) // silently fail if error
          return
        }
        
        let image = UIImage(data: data)
        completion(image)
      }
    }
    
    task.resume()
    return task
  }
}
