import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
  static let reuseID = "TweetCollectionViewCellReuseID"
  
  private var tweetView: TweetView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func configure(with tweet: Tweet) {
    tweetView.configure(with: tweet)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    tweetView.clearView()
  }
}

private extension TweetCollectionViewCell {
  func sharedInit() {
    translatesAutoresizingMaskIntoConstraints = false
    
    tweetView = TweetView()
    
    let padding: CGFloat = 16
    contentView.addSubview(tweetView)
    tweetView.translatesAutoresizingMaskIntoConstraints = false
    tweetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
    tweetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
    tweetView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
    tweetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
  }
}
