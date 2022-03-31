import UIKit
import SnapKit

class UICollectionViewViewController: UIViewController {
    
    var imageSet = [Item]()
    var setOfURLs = [String]()
    var setOfDates = [Int]()
    var viewWidth = CGFloat(0)
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Mobile Up Gallery"
        label.font = UIFont.SFDisplaySemibold(size: 18)
        label.textColor = .black
        
        return label
    }()
    
    private var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Button exit", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.SFDisplayMedium(size: 18)
        button.setTitleColor(UIColor.black, for: .normal)
         
        return button
    }()
    
    private var safeAreaView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        for item in imageSet {
            if let url = item.sizes.last?.url{
                setOfURLs.append(url)
            }
        }
        for item in imageSet {
            setOfDates.append(item.date)
        }
        
        view.addSubview(safeAreaView)
        
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        
        rightButton.addTarget(self, action: #selector(toFirstViewController), for: .touchUpInside)
        
        self.navigationItem.titleView = label
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)

        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        makeConstraints()
        
    }

    @objc private func toFirstViewController(){
        self.dismiss(animated: true)
    }
    
     func makeConstraints(){
         let guide = view.safeAreaLayoutGuide
         NSLayoutConstraint.activate([
             safeAreaView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
             safeAreaView.bottomAnchor.constraint(equalToSystemSpacingBelow: guide.bottomAnchor, multiplier: 1.0),
             safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaView)
        }
     }
}

extension UICollectionViewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let newVC = PhotoController(url: setOfURLs[indexPath.row], date: setOfDates[indexPath.row])
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}

extension UICollectionViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setOfURLs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ThirdCollectionViewCell
        cell.configurate(url: setOfURLs[indexPath.row], width: viewWidth-1)
        
        return cell
    }
}

extension UICollectionViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewWidth = view.frame.width/2
        return CGSize(width: viewWidth-1, height: viewWidth-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
