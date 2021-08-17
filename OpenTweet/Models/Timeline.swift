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
