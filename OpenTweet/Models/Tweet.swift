import Foundation

enum ThreadType {
  case root
  case reply
}

struct Tweet: Decodable, Equatable {
  let id: String
  let author: String
  let content: String
  let date: Date
  let avatar: URL?
  let inReplyTo: String?
  
  var dateDisplay: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short

    return formatter.string(from: date)
  }
  
  var threadType: ThreadType {
    return inReplyTo == nil ? .root : .reply
  }
}
