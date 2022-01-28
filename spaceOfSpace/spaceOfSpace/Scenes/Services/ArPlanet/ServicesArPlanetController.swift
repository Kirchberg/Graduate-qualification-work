//
//  ServicesArPlanetArPlanetController.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import UIKit
import SceneKit
import ARKit
import UIDrawer

protocol ServicesArPlanetDisplayLogic: AnyObject
{
    func displaySomething(viewModel: ServicesArPlanet.Something.ViewModel)
    
}

class ServicesArPlanetViewController: UIViewController, ServicesArPlanetDisplayLogic, ViewControllerDelegate, ARSCNViewDelegate, SceneControllerDelegate{
    var restartExperienceHandler: () -> Void = {}
    var isRestartAvailable = true
    lazy var virtualObjectInteraction = VirtualObjectInteraction(sceneView: sceneView.sceneView)
    var isObjectVisible = false
    var screenCenter: CGPoint {
        let bounds = sceneView.sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    let updateQueue = DispatchQueue(label: "com.shigy.ARSolarSystemSwift")
    var coachingOverlay = ARCoachingOverlayView()
    lazy var containerView = UIView()
    
    
    
    let hidingDistance=100
    let showingDistance = -30
    let buttonSetObject=UIButton()
    var setObjBottomConst:NSLayoutConstraint?
    var addBottomConst:NSLayoutConstraint?
    var spinAutoBottomConst:NSLayoutConstraint?
    var removeBottomConst:NSLayoutConstraint?
    var focusSquare = FocusSquare()
    func chooseObject() {
        if buttonAdd.alpha != 0{
            UIView.animate(withDuration: 0.3, animations:  { [self] () -> Void in
                buttonAdd.alpha=0
                addBottomConst?.constant += CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
                
            }, completion: {_ in
                UIView.animate(withDuration: 0.3, animations: { [self] () -> Void in
                    buttonAutoSpin.alpha=1
                    spinAutoBottomConst?.constant += -CGFloat(hidingDistance)
                    self.view.layoutIfNeeded()
                    
                    buttonRemove.alpha=1
                    removeBottomConst?.constant += -CGFloat(hidingDistance)
                    self.view.layoutIfNeeded()
                })
            })
        }
        
        
        if let obj=self.sceneView.manager.ChoosenObject{
            if (!obj.isSpinning) {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
                let img=UIImage(systemName: "play", withConfiguration: imageConfig)
                buttonAutoSpin.imageView?.tintColor = .white
                buttonAutoSpin.setImage(img, for: .normal)
            }else{
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
                let img=UIImage(systemName: "pause", withConfiguration: imageConfig)
                buttonAutoSpin.imageView?.tintColor = .white
                buttonAutoSpin.setImage(img, for: .normal)
            }
        }
        
    }
    
    func loseObject(){
        if buttonAdd.alpha == 0{
            UIView.animate(withDuration: 0.3, animations:  { [self] () -> Void in
                buttonAdd.alpha=1
                addBottomConst?.constant += -CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.3, animations: { [self] () -> Void in
                buttonAutoSpin.alpha=0
                spinAutoBottomConst?.constant += CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
                
                buttonRemove.alpha=0
                removeBottomConst?.constant += CGFloat(hidingDistance)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func setupObjectName(name: String) {
        self.sceneView.nameObj=name
        print("set \(name)")
        showSetObjButton()
    }
    
    var sceneView = SceneController()
//    var sceneSystem = SolARSceneController()
    
    let sheetVc = SheetViewController()
    
    var interactor: ServicesArPlanetBusinessLogic?
    var router: (NSObjectProtocol & ServicesArPlanetRoutingLogic & ServicesArPlanetDataPassing)?
    
    
    
  
    
    let buttonBack=UIButton()
    let buttonClear=UIButton()
    let buttonInfo=UIButton()
    let buttonAdd=UIButton()
    let photoButton=UIButton()
    
    let buttonAutoSpin=UIButton()
    let buttonRemove=UIButton()
    var isSystem=false
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ServicesArPlanetInteractor()
        let presenter = ServicesArPlanetPresenter()
        let router = ServicesArPlanetRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        coachingOverlay.isUserInteractionEnabled=false
        super.viewDidLoad()
        if isSystem == false{
            sceneView.vc=self
            self.view.addSubview(sceneView.sceneView)
            sceneView.sceneView.translatesAutoresizingMaskIntoConstraints=false
            NSLayoutConstraint.activate([
                sceneView.sceneView.topAnchor.constraint(equalTo: view.topAnchor),
                sceneView.sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sceneView.sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sceneView.sceneView.heightAnchor.constraint(equalTo: view.heightAnchor),
            ])
            sceneView.setup()
        } else {
            //sceneSystem.vc=self
//            self.view.addSubview(sceneSystem.sceneView)
//            sceneSystem.sceneView.translatesAutoresizingMaskIntoConstraints=false
//            NSLayoutConstraint.activate([
//                sceneSystem.sceneView.topAnchor.constraint(equalTo: view.topAnchor),
//                sceneSystem.sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                sceneSystem.sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                sceneSystem.sceneView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            ])
//            sceneSystem.setup()
        }
        
        initSceneView()
       // sheetVc.containerVC.sc=self
        if let vc=sheetVc.containerVC.rootVC as? CustomViewController{
            vc.sc=self
        }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor=UIColor.systemGray4
        doSomething()
        setupButtons()
        setupCoachingOverlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coachingOverlay.isHidden = false
        
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.sceneView.session.run(configuration)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = ServicesArPlanet.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ServicesArPlanet.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
}

extension ServicesArPlanetViewController{
    
    func takeScreenshot(view: UIView) -> UIImageView? {
        let img = self.sceneView.snapshot()
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        return UIImageView(image: img)
    }
    
    func getImgScreenshot(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}

extension ServicesArPlanetViewController: DrawerPresentationControllerDelegate {
    func drawerMovedTo(position: DraweSnapPoint) {
        
    }
}

extension ServicesArPlanetViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting, blurEffectStyle: .dark)
    }
}

extension ServicesArPlanetViewController{
    func initSceneView() {
        
        // Set the view's delegate
        sceneView.sceneView.delegate = self
        
        setupCamera()
        sceneView.sceneView.scene.rootNode.addChildNode(focusSquare)
        sceneView.sceneView.automaticallyUpdatesLighting = false
        
        // Setup Constraints for views
        
        
        // Hook up status view controller callback(s).
        
        
        restartExperienceHandler = { [weak self] in
            self?.restartExperience()
        }
    }
    
    func setupCamera() {
        guard let camera = sceneView.sceneView.pointOfView?.camera else {
           return
        }
        
        /*
         Enable HDR camera settings for the most realistic appearance
         with environmental lighting and physically based materials.
         */
        camera.wantsHDR = true
        camera.exposureOffset = -1
        camera.minimumExposure = -1
        camera.maximumExposure = 3
    }
    
    func restartExperience() {
        guard isRestartAvailable else { return }
        
        
        resetTracking()
        
        // Disable restart for a while in order to give the session time to restart.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isRestartAvailable = true
        }
    }
    
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.virtualObjectInteraction.updateObjectToCurrentTrackingPosition()
            self.updateFocusSquare()
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        updateQueue.async {
//            if self.isObjectVisible { self.sunNode.adjustOntoPlaneAnchor(planeAnchor, using: node) }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        updateQueue.async {
            
//            if self.isObjectVisible { self.sunNode.adjustOntoPlaneAnchor(planeAnchor, using: node) }
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        _ = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
//            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
        }
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        restartExperience()
    }
    
    func updateFocusSquare() {
        if isObjectVisible || coachingOverlay.isActive {
            focusSquare.hide()
        } else {
            focusSquare.unhide()
        }
        
        // We should always have a valid world position unless the sceen is just being initialized.
        guard let (worldPosition, planeAnchor, _) = sceneView.sceneView.worldPosition(fromScreenPosition: screenCenter, objectPosition: focusSquare.lastPosition) else {
            updateQueue.async {
                self.focusSquare.state = .initializing
                self.sceneView.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
            
            return
        }
        
        updateQueue.async {
            self.sceneView.sceneView.scene.rootNode.addChildNode(self.focusSquare)
            let camera = self.sceneView.sceneView.session.currentFrame?.camera
            
            if let planeAnchor = planeAnchor {
                self.focusSquare.state = .planeDetected(anchorPosition: worldPosition, planeAnchor: planeAnchor, camera: camera)
            } else {
                self.focusSquare.state = .featuresDetected(anchorPosition: worldPosition, camera: camera)
            }
        }
    }
}

extension ServicesArPlanetViewController: ARCoachingOverlayViewDelegate {
    
    /// - Tag: HideUI
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        containerView.isHidden = true
    }
    
    /// - Tag: PresentUI
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        containerView.isHidden = false
    }
    
    /// - Tag: StartOver
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        restartExperience()
    }
    
    func setupCoachingOverlay() {
        // Set up coaching view
        coachingOverlay.session = sceneView.sceneView.session
        coachingOverlay.delegate = self
        coachingOverlay.isHidden = false
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coachingOverlay)
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        setActivatesAutomatically()
        
        // Most of the virtual objects in this sample require a horizontal surface,
        // therefore coach the user to find a horizontal plane.
        setGoal()
    }
    
    /// - Tag: CoachingActivatesAutomatically
    func setActivatesAutomatically() {
        coachingOverlay.activatesAutomatically = true
    }
    
    /// - Tag: CoachingGoal
    func setGoal() {
        coachingOverlay.goal = .horizontalPlane
    }
}

//extension ServicesArPlanetViewController: UIGestureRecognizerDelegate {
//    // MARK: - Interface Actions
//    func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
//        return !self.isObjectVisible
//    }
//
//    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
