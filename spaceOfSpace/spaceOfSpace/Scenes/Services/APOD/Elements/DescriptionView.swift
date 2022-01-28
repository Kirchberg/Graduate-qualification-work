//
//  DescriptionView.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 17.04.2021.
//

import UIKit
import Foundation

protocol MainVCDelegate {
    func canHideElem()
}

class DescriptionViewController: VerticalViewController {
    var md:MainVCDelegate?
    let containerVC:ContainerVC = {
        let vc = ContainerVC(rootViewController: Description())
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    let notchVC:NotchViewController = {
        let vc = NotchViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    let closeButton:UIButton = {
        let b=UIButton()
        b.backgroundColor=UIColor.clear
        b.layer.cornerRadius=15
        b.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let img=UIImage(systemName: "xmark.square", withConfiguration: imageConfig)
        b.imageView?.tintColor = .white
        b.setImage(img, for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints=false
        
        return b
    }()
    
    let blurredEffectView:UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurredEffectView
    }()
    
    var heightConstraint:NSLayoutConstraint!
    var notchBottomConstraint:NSLayoutConstraint!
    
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupContainerView()
    }
    
    func setupContainerView() {
        
        //setup pullbar view ( small  and setting contraints to it )
        [containerVC,notchVC].forEach { (viewController) in
            self.view.addSubview(viewController.view)
        }
        notchVC.view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        heightConstraint =  containerVC.view.heightAnchor.constraint(equalToConstant: 0)
        notchBottomConstraint = notchVC.view.topAnchor.constraint(equalTo: containerVC.view.topAnchor)
        notchVC.handleView.backgroundColor=UIColor.clear
        NSLayoutConstraint.activate([
            containerVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            heightConstraint,
            
            notchVC.view.heightAnchor.constraint(equalToConstant: 55),
            notchVC.view.leadingAnchor.constraint(equalTo: containerVC.view.leadingAnchor),
            notchVC.view.trailingAnchor.constraint(equalTo: containerVC.view.trailingAnchor),
            notchBottomConstraint
        ])
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: notchVC.view.topAnchor, constant: 5),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.trailingAnchor.constraint(equalTo: notchVC.view.trailingAnchor, constant: -10),
            
        ])
        
        //setup childViewController ( this view is the bottom sheet )
        [containerVC, notchVC].forEach { (viewController) in
            self.add(viewController)
        }
        
        let screenSize = UIScreen.main.bounds
        let heightValue = screenSize.size.height / 2
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.heightConstraint.constant =  heightValue
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
}

class Description: UIViewController {
    var titleImg:String=""
    var DescText:String=""
    
    let DescView:UITextView = {
        let tVeiw=UITextView()
        tVeiw.backgroundColor = .clear
        tVeiw.textColor = UIColor.white
        tVeiw.translatesAutoresizingMaskIntoConstraints=false
        tVeiw.isEditable=false
        tVeiw.font=UIFont(name: UIFont.systemFont(ofSize: 15).fontName, size: 15)
        return tVeiw
    }()
    
    let loading:UIActivityIndicatorView = {
        let l=UIActivityIndicatorView()
        l.hidesWhenStopped=true
        l.color=UIColor.red
        
        l.translatesAutoresizingMaskIntoConstraints=false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(DescView)
        DescView.addSubview(loading)
        DescView.text=DescText
        
        NSLayoutConstraint.activate([
            DescView.widthAnchor.constraint(equalTo: view.widthAnchor),
            DescView.heightAnchor.constraint(equalTo: view.heightAnchor),
            DescView.topAnchor.constraint(equalTo: view.topAnchor),
            DescView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 100),
            loading.heightAnchor.constraint(equalToConstant: 100),
            loading.centerXAnchor.constraint(equalTo: DescView.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: DescView.centerYAnchor)
        ])
        
        self.view.backgroundColor = UIColor(rgb: 0x1C1C1E)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController(title: titleImg, navigationVC: self.navigationController!)
    }
    
    private func setupNavigationController(title: String, navigationVC: UINavigationController) {
        navigationVC.navigationBar.topItem?.title = title
        navigationVC.navigationBar.isTranslucent = false
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(rgb: 0x1C1C1E)
        navigationVC.navigationBar.standardAppearance = appearance
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        navigationVC.navigationBar.prefersLargeTitles = true
        navigationVC.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationVC.isNavigationBarHidden = false
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        let backButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: nil,
            action: nil
        )
        navigationVC.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
}

class ContainerVC: UINavigationController {
    
    var rootVC:UIViewController
    override init(rootViewController: UIViewController) {
        self.rootVC=rootViewController
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(rgb: 0x1C1C1E)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }
}

extension DescriptionViewController{
    @objc func closeVC(){
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: {_ in
            self.view.removeFromSuperview()
        })
        md?.canHideElem()
    }
}
