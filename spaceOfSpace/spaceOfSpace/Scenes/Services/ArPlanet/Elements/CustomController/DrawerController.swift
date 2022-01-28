import UIKit
import Foundation

protocol SceneControllerDelegate: AnyObject
{
    func setupObjectName(name:String)
}

protocol SheetVcDelegate{
    func close()
}

class SheetViewController: VerticalViewController, SheetVcDelegate {
    func close() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: {_ in
            self.view.removeFromSuperview()
        })
        //self.view.removeFromSuperview()
    }
    
    let containerVC:ContainerViewController = {
        let vc = ContainerViewController(rootViewController: CustomViewController())
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    let notchVC:NotchViewController = {
        let vc = NotchViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
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
        if let v = containerVC.rootVC as? CustomViewController{
            v.parentVC = self
        }
        //setup pullbar view ( small  and setting contraints to it )
        [containerVC,notchVC].forEach { (viewController) in
            self.view.addSubview(viewController.view)
        }
        
        heightConstraint =  containerVC.view.heightAnchor.constraint(equalToConstant: 0)
        notchBottomConstraint = notchVC.view.topAnchor.constraint(equalTo: containerVC.view.topAnchor)
        
        NSLayoutConstraint.activate([
            containerVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            heightConstraint,
            
            notchVC.view.heightAnchor.constraint(equalToConstant: 20),
            notchVC.view.centerXAnchor.constraint(equalTo: containerVC.view.centerXAnchor),
            notchVC.view.widthAnchor.constraint(equalToConstant: 100),
            notchBottomConstraint
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

class CustomViewController: VerticalViewController, CustomLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    var sc:SceneControllerDelegate?
    var parentVC: SheetVcDelegate?
    var titleCollection:UILabel = {
        var title=UILabel()
        title.translatesAutoresizingMaskIntoConstraints=false
        title.textColor=UIColor.white
        title.font = UIFont.boldSystemFont(ofSize: 34.0)

        return title
    }()


    var i:String!
    
    init( _ conf:String? = nil)   {
        print("init nibName style")
        super.init(nibName: nil, bundle: nil)
        if let coll=conf{
            self.i=coll
        } else{
            self.i="main"
        }
        view.backgroundColor = UIColor(rgb: 0x1C1C1E)
    }
    
    private lazy var mainCollection: UICollectionView = {
        let collectionLayout = UICustomCollectionViewLayout()
        collectionLayout.delegate = self
        collectionLayout.cellPadding = 10
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
//        collectionView.backgroundColor = UIColor(rgb: 0x1C1C1E)
//        collectionView.backgroundColor = UIColor(rgb: 0x252525).withAlphaComponent(0.6)
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0x1C1C1E)
        self.view.addSubview(mainCollection)
        //view.addSubview(titleCollection)
//        self.view.addSubview(handleView)
        mainCollection.delegate=self
        mainCollection.dataSource=self
        let heightConstant=0

        mainCollection.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            mainCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(heightConstant)),
            mainCollection.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        mainCollection.register(CategoryItem.self, forCellWithReuseIdentifier: CategoryItem.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController(navigationVC: self.navigationController!)
    }
    
    private func setupNavigationController(navigationVC: UINavigationController) {
        navigationVC.navigationBar.isTranslucent = false
        
//        self.navigationItem.titleView?.isHidden=true
        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = UIColor(rgb: 0x1C1C1E)
        //appearance.backgroundColor = .clear
//        appearance.backgroundColor = UIColor(rgb: 0x252525).withAlphaComponent(0.6)
        
        appearance.backgroundEffect = .none
        view.backgroundColor = .systemGray4
        
        navigationVC.navigationBar.standardAppearance = appearance
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        //navigationVC.navigationBar.prefersLargeTitles = true
        navigationVC.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        if (!collections[i]!.showNavbar){
            navigationVC.isNavigationBarHidden = true
        } else {
            navigationVC.isNavigationBarHidden = false
        }
        let backButton = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationVC.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
}

class ContainerViewController: UINavigationController {
    var rootVC:UIViewController

    override init(rootViewController: UIViewController) {
        self.rootVC=rootViewController
        super.init(rootViewController: rootViewController)
        view.backgroundColor = UIColor(rgb: 0x1C1C1E)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 15.0
        self.view.backgroundColor = UIColor(rgb: 0x1C1C1E)

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        (viewController as? CustomViewController)?.sc = (rootVC as? CustomViewController)?.sc
        super.pushViewController(viewController, animated: animated)
    }
}


extension CustomViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var j=collections[i]?.image.count
        if collections[i!]?.hasCustomCells == true{
            j! += 1
        }
        return j!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItem.identifier, for: indexPath) as! CategoryItem
        var j=indexPath.item
        if collections[i!]?.hasCustomCells == true{
            if indexPath.item>=3{
                j -= 1
            }
        }
        item.categoryImage.image = UIImage(named: (collections[i!]?.image[j])!)
        item.categoryTitle.text = collections[i!]?.text[j]
        item.categoryTitle.textColor=UIColor.white
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        switch indexPath.item {
        case 0:
            return CGFloat(collections[i!]!.sizeOfFirstCell)
        case 1:
            return 177
        case 2:
            if let b=collections[i!]?.hasCustomCells{
                if b {
                    return 0
                } else {
                    return 177
                }
            }
        case 3:
            return 177
        default:
            if let b=collections[i!]?.hasCustomCells{
                if b {
                    return 0
                } else {
                    return 177
                }
            }
        }
        return 177
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.isNavigationBarHidden=false
        var j=indexPath.item
        if collections[i!]?.hasCustomCells == true{
            if indexPath.item>=3{
                j -= 1
            }
        }
        
        if (collections[i!]?.nextCollections.isEmpty == false) {
            let planetController=CustomViewController(collections[i!]?.nextCollections[j])
            planetController.parentVC=self.parentVC
            self.navigationController?.pushViewController(planetController, animated: true)
        } else {
            if let item=collections[i!]?.items[j]{
                sc?.setupObjectName(name: item)
                parentVC?.close()
            }
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.cornerRadius=15
//        cell?.backgroundColor = UIColor.red
//
//    }
//
//    // change background color back when user releases touch
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.cornerRadius=15
//        cell?.backgroundColor = UIColor.green
//    }
}

