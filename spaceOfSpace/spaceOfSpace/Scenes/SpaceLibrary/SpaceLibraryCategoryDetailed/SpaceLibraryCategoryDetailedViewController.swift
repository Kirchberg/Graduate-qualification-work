import UIKit
import Kingfisher

protocol SpaceLibraryCategoryDetailedDisplayLogic: AnyObject {
    func displayTableItems(viewModel: SpaceLibraryCategoryDetailedModel.Articles.ViewModel)
    func updateTitle(title: String)
}

class SpaceLibraryCategoryDetailedViewController: VerticalViewController, SpaceLibraryCategoryDetailedDisplayLogic {
    var interactor: SpaceLibraryCategoryDetailedBusinessLogic?
    var router: (NSObjectProtocol & SpaceLibraryCategoryDetailedRoutingLogic & SpaceLibraryCategoryDetailedDataPassing)?
    
    private var displayedItems: [SpaceLibraryArticle]?
    
    private static let rowHeight: CGFloat = 90
    
    var spinnerView = ProgressHUD(text: "Loading")
    var spinnerFooterView = UIView()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .none
        
        tableView.register(ArticleItem.self, forCellReuseIdentifier: ArticleItem.identifier)
                
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private func setup() {
        let viewController = self
        let interactor = SpaceLibraryCategoryDetailedInteractor()
        let presenter = SpaceLibraryCategoryDetailedPresenter()
        let router = SpaceLibraryCategoryDetailedRouter()
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
        
        view.addSubview(tableView)

        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        spinnerView = spinnerView.useConstraints(addToView: view)
        spinnerView.show()
        
        spinnerFooterView = createSpinnerFooter()
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
        
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.getTitle()
        interactor?.getArticles()
    }
    
    func displayTableItems(viewModel: SpaceLibraryCategoryDetailedModel.Articles.ViewModel) {
        displayedItems = viewModel.displayedItems
        
        tableView.reloadData()
        
        spinnerView.hide()
    }
    
    func updateTitle(title: String) {
        self.title = title
    }
}

extension SpaceLibraryCategoryDetailedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToArticle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SpaceLibraryCategoryDetailedViewController.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedItems?.count ?? 0
    }
}

extension SpaceLibraryCategoryDetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: ArticleItem.identifier, for: indexPath) as! ArticleItem
        
        if (displayedItems != nil) {
            let articleItem = displayedItems![indexPath.section]
            
            item.articleTitle.text = articleItem.articleTitle
            
            guard let imageUrl = articleItem.articleImage else { return item }
            
            if let url = URL(string: imageUrl) {
                let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
                let processor = DownsamplingImageProcessor(size: CGSize(width: 512, height: 512))
                item.articleImage.kf.setImage(with: resource,
                                           placeholder: UIImage(named: "planet"),
                                           options: [.transition(.fade(0.75)),
                                                     .processor(processor),
                                                     .scaleFactor(UIScreen.main.scale)
                                           ],
                                           progressBlock: nil)
            }
        }
        
        item.backgroundColor = .systemGray4
        
        return item
    }
}
