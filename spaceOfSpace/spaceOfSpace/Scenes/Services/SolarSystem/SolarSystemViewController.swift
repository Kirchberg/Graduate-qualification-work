//
//  SolarSystemViewController.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import UIKit
import SceneKit
import ARKit

protocol SolarSystemDisplayLogic: AnyObject {}

class SolarSystemViewController: UIViewController, SolarSystemDisplayLogic {
    var interactor: SolarSystemBusinessLogic?
    var router: (NSObjectProtocol & SolarSystemRoutingLogic & SolarSystemDataPassing)?
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SolarSystemInteractor()
        let presenter = SolarSystemPresenter()
        let router = SolarSystemRouter()
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
    
    // MARK: - UI Elements
    
    lazy var containerView = UIView()
    
    var coachingOverlay = ARCoachingOverlayView()
    
    lazy var sceneView: VirtualObjectARView = {
        let sceneView = VirtualObjectARView()
        return sceneView
    }()
    
    private var focusSquare = FocusSquare()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton()
        return backButton
    }()
    
    lazy var clearButton: UIButton = {
        let clearButton = UIButton()
        return clearButton
    }()
    
    lazy var addSolarSystemButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    var isSpinnng: Bool = true
    
    lazy var spinButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    /// Trigerred when the "Restart Experience" button is tapped.
    var restartExperienceHandler: () -> Void = {}
    
    // MARK: - ARKit Configuration Properties
    
    /// A type which manages gesture manipulation of virtual content in the scene.
    lazy var virtualObjectInteraction = VirtualObjectInteraction(sceneView: sceneView)
    
    /// the planetnode is loaded.
    lazy var isObjectVisible = false;
    
    /// the root node of solar system
    lazy var sunNode = initSunNode()
    
    /// Marks if the AR experience is available for restart.
    var isRestartAvailable = true
    
    /// A serial queue used to coordinate adding or removing nodes from the scene.
    let updateQueue = DispatchQueue(label: "com.shigy.ARSolarSystemSwift")
    
    var screenCenter: CGPoint {
        let bounds = sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationController?.setNavigationBarHidden(true, animated: true)
        initSceneView()
        coachingOverlay.isUserInteractionEnabled=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coachingOverlay.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        addSolarSystemButton.isHidden = false
        spinButton.isHidden = true
        clearButton.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func initSceneView() {
        
        // Set the view's delegate
        sceneView.delegate = self
        
        setupCamera()
        sceneView.scene.rootNode.addChildNode(focusSquare)
        sceneView.automaticallyUpdatesLighting = false
        
        // Setup Constraints for views
        setupConstraints()
        
        // Hook up status view controller callback(s).
        addSolarSystemButton.addTarget(self, action: #selector(initPlanetNode), for: .touchUpInside)
        
        restartExperienceHandler = { [weak self] in
            self?.restartExperience()
        }
    }
    
    @objc func initPlanetNode() {
        
        guard !isObjectVisible else { return }
        
        ///Used to determine whether planet node is loaded
        isObjectVisible = true
        
        /// planetnode is added, hide the add button
        addSolarSystemButton.isHidden = true
        spinButton.isHidden = false
        clearButton.isHidden = false
        
        guard let cameraTransform = session.currentFrame?.camera.transform,
              let focusSquarePosition = focusSquare.lastPosition else { return }
        
        virtualObjectInteraction.selectedObject = sunNode
        sunNode.setPosition(focusSquarePosition, relativeTo: cameraTransform, smoothMovement: false)
        
        updateQueue.async {
            self.sceneView.scene.rootNode.addChildNode(self.sunNode)
        }
    }
    
    func initSunNode() -> PlanetNode {
        
        let sunNode = PlanetNode(planet: .sun)
        let earthNode = PlanetNode(planet: .earth)
        
        sunNode.addPlanet(planet: .mercury)
        sunNode.addPlanet(planet: .venus)
        sunNode.addPlanet(planet: .mars)
        sunNode.addPlanet(planet: .jupiter)
        sunNode.addPlanet(planet: .saturn)
        sunNode.addPlanet(planet: .uranus)
        sunNode.addPlanet(planet: .neptune)
        
        earthNode.addPlanet(planet: .moon)
        sunNode.addPlanet(planetNode: earthNode)
        
        return sunNode
    }
    
    // MARK: - Scene content setup
    
    func setupCamera() {
        guard let camera = sceneView.pointOfView?.camera else {
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
    
    // MARK: - Session management
    
    /// Creates a new AR configuration to run on the `session`.
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - Focus Square
    
    func updateFocusSquare() {
        if isObjectVisible || coachingOverlay.isActive {
            focusSquare.hide()
        } else {
            focusSquare.unhide()
        }
        
        // We should always have a valid world position unless the sceen is just being initialized.
        guard let (worldPosition, planeAnchor, _) = sceneView.worldPosition(fromScreenPosition: screenCenter, objectPosition: focusSquare.lastPosition) else {
            updateQueue.async {
                self.focusSquare.state = .initializing
                self.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
            
            return
        }
        
        updateQueue.async {
            self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
            let camera = self.session.currentFrame?.camera
            
            if let planeAnchor = planeAnchor {
                self.focusSquare.state = .planeDetected(anchorPosition: worldPosition, planeAnchor: planeAnchor, camera: camera)
            } else {
                self.focusSquare.state = .featuresDetected(anchorPosition: worldPosition, camera: camera)
            }
        }
    }
    
    /// - Tag: restartExperience
    func restartExperience() {
        guard isRestartAvailable else { return }
        isRestartAvailable = false
        
        //reset object state
        isObjectVisible = false
        
        /// remove all node from sceneview
        self.sunNode.removeFromParentNode()
        self.sunNode.reset()
        
        //reset addObjectBtn state
        addSolarSystemButton.isHidden = false
        spinButton.isHidden = true
        clearButton.isHidden = true
        
        resetTracking()
        
        // Disable restart for a while in order to give the session time to restart.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isRestartAvailable = true
        }
    }
    
    // MARK: - Error handling
    
    func displayErrorMessage(title: String, message: String) {
        
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
}
