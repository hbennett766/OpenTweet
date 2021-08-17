import UIKit

class ThreadViewController: UIViewController {
  
  @IBOutlet private weak var stackView: UIStackView!
  private var thread: Thread?
  private var selectedTweet: Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Thread"
    navigationController?.navigationBar.tintColor = .darkGray
    
    configureMainTweetView(with: thread?.root, selectedTweet: selectedTweet)
    configureReplyTweetViews(with: thread?.replies, selectedTweet: selectedTweet)
  }
  
  func configure(with thread: Thread?, selectedTweet: Tweet) {
    self.thread = thread
    self.selectedTweet = selectedTweet
  }
}

private extension ThreadViewController {
  func configureMainTweetView(with rootTweet: Tweet?, selectedTweet: Tweet) {
    let rootTweetView = TweetView()
    rootTweetView.configure(with: rootTweet ?? selectedTweet)
    
    if rootTweet == selectedTweet {
      rootTweetView.backgroundColor = .systemGray6
    }
    
    stackView.addArrangedSubview(rootTweetView)
  }
  
  func configureReplyTweetViews(with replies: [Tweet]?, selectedTweet: Tweet) {
    guard let replies = replies else {
      return
    }
    
    for reply in replies {
      let replyStackView = UIStackView()
      replyStackView.spacing = 16
      
      let arrowLabel = UILabel()
      arrowLabel.text = "    ⤷"
      arrowLabel.font = .systemFont(ofSize: 20)
      replyStackView.addArrangedSubview(arrowLabel)
      
      let tweetStackView = UIStackView()
      tweetStackView.axis = .vertical
      tweetStackView.alignment = .leading
      tweetStackView.spacing = 4
      
      let authorLabel = UILabel()
      authorLabel.text = reply.author
      authorLabel.font = .systemFont(ofSize: 10, weight: .bold)
      authorLabel.textColor = UIColor(red: 45/255, green: 174/255, blue: 156/255, alpha: 1)
      tweetStackView.addArrangedSubview(authorLabel)
      
      let tweetLabel = UILabel()
      tweetLabel.text = reply.content
      tweetLabel.font = .systemFont(ofSize: 14)
      tweetLabel.numberOfLines = 0
      tweetStackView.addArrangedSubview(tweetLabel)
      
      let dateLabel = UILabel()
      dateLabel.text = reply.dateDisplay
      dateLabel.font = .systemFont(ofSize: 10)
      dateLabel.textColor = .systemGray
      tweetStackView.addArrangedSubview(dateLabel)
      
      if reply == selectedTweet {
        replyStackView.backgroundColor = .systemGray6
      }
      
      replyStackView.addArrangedSubview(tweetStackView)
      stackView.addArrangedSubview(replyStackView)
    }
  }
}
