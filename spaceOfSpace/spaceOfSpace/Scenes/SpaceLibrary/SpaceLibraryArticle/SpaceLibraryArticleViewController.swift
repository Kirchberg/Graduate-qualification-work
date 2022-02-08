import UIKit
import Kingfisher

extension UIScrollView {
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview?.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.setContentOffset(CGPoint(x: 0, y: childStartPoint.y), animated: animated)
        }
    }
}

protocol SpaceLibraryArticleDisplayLogic: AnyObject {
    func displayBackgroundImage(viewModel: SpaceLibraryArticleModel.Article.ViewModel)
    func displayArticles(viewModel: SpaceLibraryArticleModel.Article.ViewModel)
    func updateTitle(title: String)
    func goToSection(sectionTitle: String)
}

class SpaceLibraryArticleViewController: VerticalViewController, SpaceLibraryArticleDisplayLogic {
    var interactor: SpaceLibraryArticleBusinessLogic?
    var router: (NSObjectProtocol & SpaceLibraryArticleRoutingLogic & SpaceLibraryArticleDataPassing)?
    
    let backgroundImage = UIImageView()
    let scrollView = UIScrollView()
    let articleView = UIView()
    let citationLabel = UILabel()
    var spinnerView = ProgressHUD(text: "Loading")
    var spinnerFooterView = UIView()
    
    var botAnchor = NSLayoutYAxisAnchor()


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
    
    private func setup() {
        let viewController = self
        let interactor = SpaceLibraryArticleInteractor()
        let presenter = SpaceLibraryArticlePresenter()
        let router = SpaceLibraryArticleRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = [.top, .left, .right]
        
        let tocImage = UIImage(systemName: "list.bullet")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: tocImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tocButtonTapped))
        
        backgroundImage.image = UIImage(named: "planet")
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        
        view.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
                
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        articleView.backgroundColor = UIColor.systemGray4.withAlphaComponent(0.8)
        
        scrollView.addSubview(articleView)
        
        articleView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            articleView.leftAnchor.constraint(equalTo: view.leftAnchor),
            articleView.rightAnchor.constraint(equalTo: view.rightAnchor),
            articleView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200),
            articleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        botAnchor = citationLabel.bottomAnchor
        
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
    
    func addCitationLabel() {
        citationLabel.text = "From Wikipedia, the free encyclopedia"
        citationLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        citationLabel.translatesAutoresizingMaskIntoConstraints = false

        articleView.addSubview(citationLabel)

        NSLayoutConstraint.activate([
            citationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            citationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            citationLabel.topAnchor.constraint(equalTo: articleView.topAnchor, constant: 9)
        ])
    }
    
    func addArticleSection(text: String) {
        let articleText = UILabel()
        articleText.text = text
        articleText.numberOfLines = 0
        articleText.font = .systemFont(ofSize: 15, weight: .regular)
        
        articleView.addSubview(articleText)
        
        articleText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            articleText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            articleText.topAnchor.constraint(equalTo: botAnchor, constant: 7)
        ])
        
        botAnchor = articleText.bottomAnchor
    }
    
    func addArticleTitle(text: String, level: Int) {
        let articleTitle = UILabel()
        var separator: UIView?
        
        articleTitle.text = text
        
        if level <= 1 {
            articleTitle.font = .systemFont(ofSize: 24, weight: .regular)
            
            separator = UIView()
            separator!.backgroundColor = UIColor(white: 1, alpha: 0.6)
            
            articleView.addSubview(separator!)
            
            separator!.translatesAutoresizingMaskIntoConstraints = false
            
        } else {
            articleTitle.font = .systemFont(ofSize: 22, weight: .regular)
        }
                
        articleView.addSubview(articleTitle)
        
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            articleTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            articleTitle.topAnchor.constraint(equalTo: botAnchor, constant: 14),
        ])
        botAnchor = articleTitle.bottomAnchor
        
        if level <= 1 {
            NSLayoutConstraint.activate([
                separator!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
                separator!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
                separator!.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8),
                separator!.heightAnchor.constraint(equalToConstant: 1)
            ])
            botAnchor = separator!.bottomAnchor
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.getTitle()
        interactor?.getArticleText()
    }
    
    @objc private func tocButtonTapped() {
        router?.presentToc()
    }
    
    // MARK: Do something
    
    func updateTitle(title: String) {
        self.title = title
    }
    
    func displayBackgroundImage(viewModel: SpaceLibraryArticleModel.Article.ViewModel) {
        guard let imageUrl = viewModel.displayedItems.articleImage else { return }
        
        if let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url, cacheKey: imageUrl)
            backgroundImage.kf.setImage(with: resource,
                                        placeholder: UIImage(named: "planet"),
                                        options: [.transition(.fade(0.75)),
                                                  .scaleFactor(UIScreen.main.scale)
                                        ],
                                        progressBlock: nil)
        }
    }
    
    func displayArticles(viewModel: SpaceLibraryArticleModel.Article.ViewModel) {
        addCitationLabel()
        
        for section in viewModel.displayedItems.articleSections! {
            if section.sectionTitle != nil {
                addArticleTitle(text: section.sectionTitle!, level: section.sectionLevel)
            }
            if section.sectionText != nil {
                addArticleSection(text: section.sectionText!)
            }
        }

        NSLayoutConstraint.activate([ botAnchor.constraint(equalTo: articleView.bottomAnchor, constant: -15) ])
        
        spinnerView.hide()
    }
    
    func goToSection(sectionTitle: String) {
        for subview in articleView.subviews {
            guard let label = subview as? UILabel else { continue }
            if label.text == sectionTitle {
                scrollView.scrollToView(view: label, animated: true)
            }
        }
    }
}
