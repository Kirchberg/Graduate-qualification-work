import UIKit
import Kingfisher
import WidgetKit
import SMScrollView

protocol ApodDisplayLogic: AnyObject {
    func displayImg(viewModel: Apod.GetImgUrl.ViewModel)
}

class ApodViewController: UIViewController, ApodDisplayLogic, UIScrollViewDelegate, MainVCDelegate {
    func canHideElem() {
        isHidden=1
    }
    

    
    var myScrollView: SMScrollView?
    var interactor: ApodBusinessLogic?
    var router: (NSObjectProtocol & ApodRoutingLogic & ApodDataPassing)?
    
    let buttonBack=UIButton()
    let buttonInfo=UIButton()
    let buttonRefresh=UIButton()
    let buttonSave=UIButton()
    let labelTitle=UILabel()
    let viewDescription=DescriptionViewController()
    var isHidden:Int=1
    var buttonSaveTopConstraint:NSLayoutConstraint?=nil
    var buttonInfoTopConstraint:NSLayoutConstraint?=nil
    var buttonRefreshTopConstraint:NSLayoutConstraint?=nil
    var buttonBackTopConstraint:NSLayoutConstraint?=nil
    var labelTitleBottomConstraint:NSLayoutConstraint?=nil
    var isPhotoLoaded=false
    let loader:UIActivityIndicatorView = {
        let l=UIActivityIndicatorView()
        l.hidesWhenStopped=true
        l.color=UIColor.systemGray
        
        l.translatesAutoresizingMaskIntoConstraints=false
        return l
    }()
    
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
        let interactor = ApodInteractor()
        let presenter = ApodPresenter()
        let router = ApodRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
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
        view.addSubview(loader)
        viewDescription.md=self
        if let vc=viewDescription.containerVC.rootVC as? Description{
            vc.loading.startAnimating()
        }
        loader.startAnimating()
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        self.view.backgroundColor = UIColor.black
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let imageView=UIImageView(image: UIImage(withBackground: UIColor.black))
        myScrollView = SMScrollView(frame: view.bounds)
        myScrollView?.maximumZoomScale = 2
        myScrollView?.delegate = self
        myScrollView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myScrollView?.contentSize = imageView.frame.size
        myScrollView?.alwaysBounceVertical = true
        myScrollView?.alwaysBounceHorizontal = true
        myScrollView?.stickToBounds = true
        myScrollView?.add(forZooming: imageView)
        myScrollView?.scaleToFit()
        if let myScrollView = myScrollView {
            view.addSubview(myScrollView)
        }
        setupViewElem()
        gestureRecognizer()
        if !isPhotoLoaded{
            setImg()
        }
    }
    
    func gestureRecognizer(){
        let tap=UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func setImg() {
        let request = Apod.GetImgUrl.Request()
        interactor?.loadImg(request: request)//load img
        isPhotoLoaded=true
    }
    
    func displayImg(viewModel: Apod.GetImgUrl.ViewModel) {
        guard let url=viewModel.url, let title=viewModel.title, let desc=viewModel.description else {
            return
        }
        if let vc=viewDescription.containerVC.rootVC as? Description{
            vc.loading.stopAnimating()
            vc.loading.isHidden=true
            vc.loading.removeFromSuperview()
            vc.titleImg=title
            vc.DescText=desc
            labelTitle.text=title
        }
        downloadImage(from: url)
    }
    
    func downloadImage(from url: URL) {
        let imageView=UIImageView()
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "APOD"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                self.loader.stopAnimating()
                let imageView = UIImageView(image: value.image)
                self.myScrollView?.contentSize=imageView.frame.size
                self.myScrollView?.add(forZooming: imageView)
                self.myScrollView?.scaleToFit()
                
                if #available(iOS 14.0, *) {
                    let userDefaults = UserDefaults(suiteName: "group.RiftsCache")
                    guard let ud = userDefaults else {
                        print("Failed HERE")
                        return
                    }
                    let data=value.image.jpegData(compressionQuality: 1.0)
                    ud.set(data, forKey: "img")
                    WidgetCenter.shared.reloadAllTimelines()
                } else {
                    return
                }
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
                self.setImg()
            }
        }
    }
    
}

extension ApodViewController{
    @objc func tapped(recognizer: UIGestureRecognizer){
        if isHidden==0{
            show()
        } else if isHidden==1{
            hide()
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return UIInterfaceOrientationMask(rawValue: (UIInterfaceOrientationMask.portrait.rawValue | UIInterfaceOrientationMask.landscapeLeft.rawValue))
        return .all
    }

//    @objc func rotated() {
//        if UIDevice.current.orientation.isLandscape {
//            imageScrollView.zoom(to: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height), animated: true)
//
//        } else {
//            imageScrollView.zoom(to: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width), animated: true)
//        }
//
//
//    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myScrollView?.viewForZooming
    }
}
