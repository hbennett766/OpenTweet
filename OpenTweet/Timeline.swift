import Foundation

struct Timeline: Decodable {
  let timeline: [Tweet]
}

struct Tweet: Decodable {
  let id: String
  let author: String
  let content: String
  let date: Date
  let avatar: URL?
  let inReplyTo: String?
}
