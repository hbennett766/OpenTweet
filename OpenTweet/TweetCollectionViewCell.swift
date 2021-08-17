import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
  static let reuseID = "TweetCollectionViewCellReuseID"
  
  private var tweetLabel: UILabel!
  private var authorLabel: UILabel!
  private var dateLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func configure(with tweet: Tweet) {
    tweetLabel.text = tweet.content
    authorLabel.text = tweet.author
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    
    dateLabel.text = formatter.string(from: tweet.date)
  }
}

private extension TweetCollectionViewCell {
  func sharedInit() {
    translatesAutoresizingMaskIntoConstraints = false
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 16
    
    let padding: CGFloat = 16
    contentView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
    stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
    stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
    stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
    
    tweetLabel = UILabel()
    tweetLabel.font = .systemFont(ofSize: 16)
    tweetLabel.textColor = .systemGray
    stackView.addArrangedSubview(tweetLabel)
    
    let authorAndDateStackView = UIStackView()
    authorAndDateStackView.spacing = 8
    stackView.addArrangedSubview(authorAndDateStackView)
    
    authorLabel = UILabel()
    authorLabel.font = .systemFont(ofSize: 12, weight: .bold)
    authorLabel.textColor = .systemGray5
    authorAndDateStackView.addArrangedSubview(authorLabel)
    
    dateLabel = UILabel()
    dateLabel.font = .systemFont(ofSize: 12)
    dateLabel.textColor = .systemGray5
    dateLabel.textAlignment = .right
    authorAndDateStackView.addArrangedSubview(dateLabel)
  }
}
