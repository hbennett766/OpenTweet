import UIKit

class TimelineViewController: UIViewController {
  
  private var collectionView: UICollectionView!
  private var tweets: [Tweet] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
    title = "Timeline"
	}
}

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCollectionViewCell.reuseID, for: indexPath) as? TweetCollectionViewCell else {
      return UICollectionViewCell()
    }

    let tweet = tweets[indexPath.row]
    cell.configure(with: tweet)

    return cell
  }
}

private extension TimelineViewController {
  func setUpCollectionView() {
    let layout = createLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    collectionView.register(TweetCollectionViewCell.self, forCellWithReuseIdentifier: TweetCollectionViewCell.reuseID)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    self.collectionView = collectionView
  }
  
  func createLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
      
      let section = NSCollectionLayoutSection(group: group)
      
      return section
    }
  }
}
