import XCTest
@testable import OpenTweet

class OpenTweetThreadTests: XCTestCase {
    
  func testThreadCreation() {
    let timeline = Timeline(timeline: [squints, smalls1, kenny, bertram, yeahyeah, smalls2, benny, ham])
    let expectedRootID = squints.id
    let expectedReplyIDs = [smalls1, kenny, bertram, yeahyeah, smalls2, benny, ham].map { $0.id }
    
    XCTAssertEqual(expectedRootID, timeline.threads.first?.root.id)
    XCTAssertEqual(expectedReplyIDs, timeline.threads.first?.replies.map { $0.id })
  }
}

private extension OpenTweetThreadTests {
  var squints: Tweet {
    return Tweet(
      id: "001",
      author: "@for-e-ver",
      content: "But it was signed by Babe Ruth!",
      date: Date(),
      avatar: nil,
      inReplyTo: nil
    )
  }
  
  var smalls1: Tweet {
    return Tweet(
      id: "002",
      author: "@ScottSmalls",
      content: "Yeah, you keep telling me that! Who is she?",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
  
  var kenny: Tweet {
    return Tweet(
      id: "014",
      author: "@HeaterKenny",
      content: "The sultan of swat!",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
  
  var bertram: Tweet {
    return Tweet(
      id: "016",
      author: "@BigChief",
      content: "The king of crash!",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
  
  var yeahyeah: Tweet {
    return Tweet(
      id: "025",
      author: "@yeahyeah",
      content: "BABE RUTH!",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
  
  var smalls2: Tweet {
    return Tweet(
      id: "043",
      author: "@ScottSmalls",
      content: "Oh my god! You mean that's the same guy?",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
  
  var benny: Tweet {
    return Tweet(
      id: "055",
      author: "@TheJet",
      content: "Smalls, Babe Ruth is the greatest baseball player that ever lived. People say he was less than a god but more than a man. You know, like Hercules or something. That ball you just aced to The Beast is worth, well, more than your whole life.",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
  
  var ham: Tweet {
    return Tweet(
      id: "099",
      author: "@TheGreatHambino",
      content: "You're killin' me Smalls",
      date: Date(),
      avatar: nil,
      inReplyTo: "001"
    )
  }
}
