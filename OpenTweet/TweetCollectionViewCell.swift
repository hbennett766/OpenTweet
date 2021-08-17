import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
  static let reuseID = "TweetCollectionViewCellReuseID"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func configure(with tweet: Tweet) {
    
  }
}

private extension TweetCollectionViewCell {
  func sharedInit() {
    
  }
}
