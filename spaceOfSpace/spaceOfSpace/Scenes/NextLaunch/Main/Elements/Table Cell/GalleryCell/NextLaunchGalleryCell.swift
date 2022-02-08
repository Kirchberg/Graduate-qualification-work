import UIKit

class NextLaunchGalleryCell: UITableViewCell, CellProtocol {
    
    var parentViewController: UIViewController?
    static var identifier: String = "NextLaunchGallery"
    
    lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 142, height: 114)
        flowLayout.minimumLineSpacing = 7.0
        flowLayout.minimumInteritemSpacing = 7.0
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionView.register(NextLaunchPhotoCell.self, forCellWithReuseIdentifier: NextLaunchPhotoCell.identifier)
        
        return collectionView
    }()
    
    var galleryPhotosView: [NextLaunchPhotoCell]?
    var galleryPhotosURL: [URL]?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateWith(vm: NextLaunchCellVMProtocol) {
        guard let vm = vm as? NextLaunchGalleryCellVM else { return }
        galleryPhotosURL = vm.photosURL
        backgroundColor = .clear
    }
    
    private func setupCell() {
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = collectionView.useConstraints(addToView: contentView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 143)
        ])
        
        registerCells()
    }
    
    private func registerCells() {
        [NextLaunchPhotoCell.self].forEach {
            collectionView.register($0, forCellWithReuseIdentifier: NSStringFromClass($0))
        }
    }
}

extension NextLaunchGalleryCell: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryPhotosURL?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextLaunchPhotoCell.identifier, for: indexPath) as? NextLaunchPhotoCell {
            cell.updateWith(imageURL: galleryPhotosURL?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
