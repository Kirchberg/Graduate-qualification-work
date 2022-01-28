import UIKit

protocol SpaceLibraryCategoriesDisplayLogic: AnyObject {
    func displayCollectionItems(viewModel: SpaceLibraryCategoriesModel.Categories.ViewModel)
}

class SpaceLibraryCategoriesViewController: VerticalViewController, SpaceLibraryCategoriesDisplayLogic {
    
    var interactor: SpaceLibraryCategoriesBusinessLogic?
    var router: (NSObjectProtocol & SpaceLibraryCategoriesRoutingLogic & SpaceLibraryCategoriesDataPassing)?
    
    private var displayedItems: [SpaceLibraryCategory]?
    
    private static let itemPadding: CGFloat = 10
    private static let smallItemHeight: CGFloat = 177
    private static let bigItemHeight: CGFloat = (smallItemHeight + itemPadding) * 2
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICustomCollectionViewLayout()
        collectionLayout.delegate = self
        collectionLayout.cellPadding = SpaceLibraryCategoriesViewController.itemPadding
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        
        collectionView.register(CategoryItem.self, forCellWithReuseIdentifier: CategoryItem.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private func setup() {
        let viewController = self
        let interactor = SpaceLibraryCategoriesInteractor()
        let presenter = SpaceLibraryCategoriesPresenter()
        let router = SpaceLibraryCategoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray4
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = [.top, .left, .right]
        
        view.addSubview(collectionView)

        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
                
        interactor?.getCategories(request: SpaceLibraryCategoriesModel.Categories.Request())
    }
        
    func displayCollectionItems(viewModel: SpaceLibraryCategoriesModel.Categories.ViewModel) {
        displayedItems = viewModel.displayedItems
        
        collectionView.reloadData()
    }
}

extension SpaceLibraryCategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToCategoryDetailed()
    }
}

extension SpaceLibraryCategoriesViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return indexPath.item % 3 == 0 ? SpaceLibraryCategoriesViewController.bigItemHeight : SpaceLibraryCategoriesViewController.smallItemHeight
    }
}

extension SpaceLibraryCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItem.identifier, for: indexPath) as! CategoryItem
        
        if (displayedItems != nil) {
            let categoryItem = displayedItems![indexPath.item]
            
            item.categoryTitle.text = categoryItem.categoryTitle
            item.categoryImage.image = UIImage(named: categoryItem.categoryImage ?? "rocket")
        }
        
        return item
    }
    
}
