import UIKit

class TimelineViewController: UIViewController {
  
  private var collectionView: UICollectionView!
  private var threads: [Thread] = []
  private var tweets: [Tweet] = []

	override func viewDidLoad() {
		super.viewDidLoad()
    
    setUpCollectionView()
    loadTimeline()
	}
}

private extension TimelineViewController {
  func loadTimeline() {
    APIClient.shared.loadTimeline { [weak self] result in
      switch result {
      case .success(let timelineResponse):
        self?.threads = timelineResponse.threads
        self?.tweets = timelineResponse.timeline
        self?.collectionView.reloadData()
      case .failure(let error):
        self?.presentErrorAlert(error: error)
      }
    }
  }
  
  func presentErrorAlert(error: Error) {
    let alertController = UIAlertController(
      title: "Sorry, something went wrong",
      message: error.localizedDescription,
      preferredStyle: .alert
    )
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedTweet = tweets[indexPath.row]
    let thread = getThread(for: selectedTweet)
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let threadViewController = storyboard.instantiateViewController(identifier: "ThreadViewController") as! ThreadViewController
    threadViewController.configure(with: thread, selectedTweet: selectedTweet)
    
    navigationController?.pushViewController(threadViewController, animated: true)
  }
}

private extension TimelineViewController {
  func getThread(for selectedTweet: Tweet) -> Thread? {
    var thread: Thread? = nil
    
    switch selectedTweet.threadType {
    case .root:
      thread = threads.first { $0.root.id == selectedTweet.id }
      
    case .reply:
      thread = threads.first { t in
        return t.replies.contains { $0.id == selectedTweet.id }
      }
    }
    
    return thread
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
