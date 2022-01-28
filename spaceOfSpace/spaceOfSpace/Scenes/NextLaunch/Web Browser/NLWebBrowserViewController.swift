//
//  NLWebBrowserViewController.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 24.05.2021.
//

import UIKit
import WebKit

class NLWebBrowserViewController: UIViewController {
    
    var interactor: NLWebBrowserInteractorProtocol?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.viewIsReady()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.removeFromSuperview()
    }
    
    // MARK: UI
    
    private var progress = 0
    private var urlToShow: URL?
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        var webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: &progress)
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressViewStyle = .bar
        progressView.tintColor = UIColor(rgb: 0x2A82FF)
        return progressView
    }()
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .systemIndigo
        
        let actionImage = UIImage(systemName: "square.and.arrow.up")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: actionImage,
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped)
        )
        
        webView = webView.useConstraints(addToView: view)
        progressView = progressView.useConstraints(addToView: view)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    @objc private func shareButtonTapped() {
        let sourceWebsite = urlToShow
        let shareLink = [sourceWebsite]
        let activityViewController = UIActivityViewController(activityItems: shareLink as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToFacebook,
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func displayWebBrowser(with URL: URL) {
        let myRequest = URLRequest(url: URL)
        urlToShow = URL
        webView.load(myRequest)
    }
}

extension NLWebBrowserViewController: WKNavigationDelegate, WKUIDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change else { return }
        if context != &progress {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        if keyPath == "estimatedProgress" {
            if let progress = (change[NSKeyValueChangeKey.newKey] as AnyObject).floatValue {
                progressView.progress = progress
            }
            return
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
}
