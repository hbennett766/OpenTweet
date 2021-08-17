import UIKit

class TweetView: UIView {
  
  private var avatarImageView: UIImageView!
  private var tweetLabel: UILabel!
  private var authorLabel: UILabel!
  private var dateLabel: UILabel!
  
  private var imageDataTask: URLSessionDataTask? = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func configure(with tweet: Tweet) {
    fetchAvatar(from: tweet.avatar)
    formatTweetLabel(from: tweet.content)
    authorLabel.text = tweet.author
    formatDateLabel(from: tweet.date)
  }
  
  func clearView() {
    avatarImageView.image = nil
    imageDataTask?.cancel()
    tweetLabel.attributedText = nil
    authorLabel.text = nil
    dateLabel.text = nil
  }
}

private extension TweetView {
  func fetchAvatar(from url: URL?) {
    guard let url = url else {
      avatarImageView.isHidden = true
      return
    }
    
    avatarImageView.isHidden = false
    imageDataTask = APIClient.shared.loadAvatar(from: url, completion: { [weak self] image in
      self?.avatarImageView.image = image
      self?.imageDataTask = nil
    })
  }
  
  func formatTweetLabel(from text: String) {
    let attributedString = NSMutableAttributedString(string: text)
    let newlinesReplaced = text.replacingOccurrences(of: "\n", with: " ")
    let words = newlinesReplaced.split(separator: " ")
    
    for word in words {
      if word.starts(with: "@") {
        let range = (text as NSString).range(of: String(word))
        attributedString.addAttribute(
          NSAttributedString.Key.backgroundColor,
          value: UIColor(red: 45/255, green: 174/255, blue: 156/255, alpha: 0.4),
          range: range
        )
        
      } else if word.starts(with: "https://") {
        let range = (text as NSString).range(of: String(word))
        attributedString.addAttribute(
          NSAttributedString.Key.foregroundColor,
          value: UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1),
          range: range
        )
      }
    }
    
    tweetLabel.attributedText = attributedString
  }
  
  func formatDateLabel(from date: Date) {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short

    dateLabel.text = formatter.string(from: date)
  }
}

private extension TweetView {
  func sharedInit() {
    translatesAutoresizingMaskIntoConstraints = false
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 8
    
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    let teal = UIColor(red: 45/255, green: 174/255, blue: 156/255, alpha: 1)
    
    let line = UIView()
    line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    line.backgroundColor = teal
    stackView.addArrangedSubview(line)
    line.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    
    let titleStackView = UIStackView()
    titleStackView.spacing = 8
    stackView.addArrangedSubview(titleStackView)
    
    avatarImageView = UIImageView()
    avatarImageView.backgroundColor = .systemGray6
    avatarImageView.contentMode = .scaleAspectFill
    avatarImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
    avatarImageView.layer.cornerRadius = 15
    avatarImageView.clipsToBounds = true
    titleStackView.addArrangedSubview(avatarImageView)
    
    authorLabel = UILabel()
    authorLabel.font = .systemFont(ofSize: 12, weight: .bold)
    authorLabel.textColor = teal
    titleStackView.addArrangedSubview(authorLabel)
    
    tweetLabel = UILabel()
    tweetLabel.font = .systemFont(ofSize: 16)
    tweetLabel.numberOfLines = 0
    stackView.addArrangedSubview(tweetLabel)
    
    dateLabel = UILabel()
    dateLabel.font = .systemFont(ofSize: 12)
    dateLabel.textColor = .systemGray
    stackView.addArrangedSubview(dateLabel)
  }
}
