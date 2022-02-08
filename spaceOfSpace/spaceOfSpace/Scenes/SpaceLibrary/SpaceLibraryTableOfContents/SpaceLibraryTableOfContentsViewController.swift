import UIKit

protocol SpaceLibraryTableOfContentsDisplayLogic: AnyObject {
    func displayTitles(sections: [SpaceLibraryArticleSection])
}

class SpaceLibraryTableOfContentsViewController: UIViewController, SpaceLibraryTableOfContentsDisplayLogic {
    var interactor: SpaceLibraryTableOfContentsBusinessLogic?
    var router: (NSObjectProtocol & SpaceLibraryTableOfContentsRoutingLogic & SpaceLibraryTableOfContentsDataPassing)?
    
    private var displayedItems: [SpaceLibraryArticleSection]?
    
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
        
        tableView.register(TitleItem.self, forCellReuseIdentifier: TitleItem.identifier)
                
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private func setup() {
        let viewController = self
        let interactor = SpaceLibraryTableOfContentsInteractor()
        let presenter = SpaceLibraryTableOfContentsPresenter()
        let router = SpaceLibraryTableOfContentsRouter()
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
        
        view.addSubview(tableView)

        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getArticle()
    }
    
    // MARK: Do something
        
    func getArticle() {
        interactor?.getArticle()
    }
    
    func displayTitles(sections: [SpaceLibraryArticleSection]) {
        displayedItems = sections
        
        tableView.reloadData()
    }
}

extension SpaceLibraryTableOfContentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.goToSection(sectionTitle: displayedItems?[indexPath.row].sectionTitle ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SpaceLibraryTableOfContentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: TitleItem.identifier, for: indexPath) as! TitleItem
                
        if (displayedItems != nil) {
            let articleItem = displayedItems![indexPath.row]
            item.articleTitle.text = articleItem.sectionTitle
            item.articleTitle.font = UIFont.systemFont(ofSize: articleItem.sectionLevel <= 1 ? 24 : 22, weight: articleItem.sectionLevel <= 1 ? .bold : .regular)
            item.setupLevel(level: articleItem.sectionLevel)
        }
        
        item.backgroundColor = .systemGray4
        return item
    }
}
