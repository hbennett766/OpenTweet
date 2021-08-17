import Foundation

struct Timeline: Decodable {
  let timeline: [Tweet]
  
  var threads: [Thread] {
    var threads: [Thread] = []
    
    var replies: [String: [Tweet]] = [:]
    for tweet in timeline {
      if let id = tweet.inReplyTo {
        var existingReplies = replies[id] ?? []
        existingReplies.append(tweet)
        replies[id] = existingReplies
      }
    }
    
    for reply in replies {
      let root = timeline.first { $0.id == reply.key }
      if let root = root {
        threads.append(Thread(root: root, replies: reply.value))
      }
    }
    
    return threads
  }
}

struct Thread {
  let root: Tweet
  let replies: [Tweet]
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

enum ThreadType {
  case root
  case reply
}
