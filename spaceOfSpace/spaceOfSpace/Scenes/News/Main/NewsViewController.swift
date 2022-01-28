//
//  NewsViewController.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit
import Kingfisher

protocol NewsDisplayLogic: AnyObject {
    func displayFetchedObjects(viewModel: NewsModel.FetchNews.ViewModel)
}

class NewsViewController: VerticalViewController, NewsDisplayLogic {
    var interactor: NewsBusinessLogic?
    var router: (NewsRoutingLogic & NewsDataPassing)?
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let router = NewsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        interactor?.fetchNews(request: NewsModel.FetchNews.Request(startFetchFrom: startFetchFrom))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.deselectSelectedRow(animated: true)
    }
    
    // MARK: Interface
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 105
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tableView
    }()
    
    var startFetchFrom: Int = 0
    var isPaginating: Bool = false
    
    var spinnerView = ProgressHUD(text: "Loading")
    var spinnerFooterView = UIView()
    
    private var displayedObjects = [DisplayedObject]()
    
    private func setupUI() {
        view.backgroundColor = .black
        
        if let tabBarController = self.tabBarController {
            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarController.tabBar.frame.height, right: 0)
            tableView.contentInset = adjustForTabbarInsets
            tableView.scrollIndicatorInsets = adjustForTabbarInsets
        }
        
        tableView.isUserInteractionEnabled = false
        tableView = tableView.useConstraints(addToView: view)
        extendedLayoutIncludesOpaqueBars = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        spinnerView = spinnerView.useConstraints(addToView: view)
        spinnerView.show()
        
        spinnerFooterView = createSpinnerFooter()
    }
    
    func displayFetchedObjects(viewModel: NewsModel.FetchNews.ViewModel) {
        displayedObjects = viewModel.displayedObjects
        isPaginating = false
        startFetchFrom += 10
        tableView.tableFooterView = nil
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier) as? NewsCell
        
        let news = displayedObjects[indexPath.row] as? NewsModel.FetchNews.ViewModel.DisplayedNews
        
        if displayedObjects.count > 0 {
            
            if let cell = cell {
                
                cell.layoutMargins = UIEdgeInsets.zero
                
                if let news = news {
                    if let url = URL(string: news.imageURL) {
                        let resource = ImageResource(downloadURL: url, cacheKey: news.imageURL)
                        let processor = DownsamplingImageProcessor(size: CGSize(width: 120, height: 120))
                        cell.newsImage.kf.indicatorType = .activity
                        cell.newsImage.kf.setImage(
                            with: resource,
                            placeholder: UIColor.darkGray.image(),
                            options: [.transition(.fade(0.75)),
                                      .processor(processor),
                                      .scaleFactor(UIScreen.main.scale)
                            ],
                            progressBlock: nil
                        )
                    }
                    
                    cell.newsTitle.text = news.title
                    cell.newsContent.text = news.content
                    cell.newsSource.text = news.datePublished
                    
                    spinnerView.hide()
                    
                    tableView.isUserInteractionEnabled = true
                }
            }
        }
        return cell ?? NewsCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToShowBrowser()
    }
}

extension NewsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) && !isPaginating {
            isPaginating = true
            self.tableView.tableFooterView = spinnerFooterView
            interactor?.fetchNews(request: NewsModel.FetchNews.Request(startFetchFrom: startFetchFrom))
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}
