//
//  Constraints + Button Actions.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import UIKit
import SceneKit

extension SolarSystemViewController {
    
    func setupConstraints() {
        
        self.view.backgroundColor = .systemGray4
        
        sceneView = sceneView.useConstraints(addToView: view)
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        containerView = containerView.useConstraints(addToView: view)
        containerView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        addSolarSystemButton = addSolarSystemButton.useConstraints(addToView: containerView)
        
        NSLayoutConstraint.activate([
            addSolarSystemButton.widthAnchor.constraint(equalToConstant: 50),
            addSolarSystemButton.heightAnchor.constraint(equalToConstant: 50),
            addSolarSystemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            addSolarSystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        spinButton = spinButton.useConstraints(addToView: containerView)
        
        NSLayoutConstraint.activate([
            spinButton.widthAnchor.constraint(equalToConstant: 50),
            spinButton.heightAnchor.constraint(equalToConstant: 50),
            spinButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            spinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        setupCoachingOverlay()
        setupBackButton()
        setupClearButton()
        setupAddSolarSystemButton()
        setupSpinningButton()
    }
    
    private func setupBackButton() {
        
        backButton = backButton.useConstraints(addToView: view)
        
        backButton.backgroundColor=UIColor(rgb: 0x1C1C1E)
        backButton.layer.cornerRadius=15
        backButton.alpha=0.6
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        let img = UIImage(systemName: "arrow.uturn.backward", withConfiguration: imageConfig)
        backButton.imageView?.tintColor = .white
        backButton.setImage(img, for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        backButton.addTarget(self, action: #selector(segueToServices(_:)), for: .touchUpInside)
    }
    
    @objc  private func segueToServices(_ button: UIButton) {
        coachingOverlay.isHidden = true
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupClearButton() {
        
        clearButton = clearButton.useConstraints(addToView: view)
        
        clearButton.backgroundColor = UIColor(rgb: 0x1C1C1E)
        clearButton.layer.cornerRadius = 15
        clearButton.alpha = 0.6
        clearButton.isHidden = true
        clearButton.setTitle("Clear", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        clearButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            clearButton.widthAnchor.constraint(equalToConstant: 90.91),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11)
        ])
        
        clearButton.addTarget(self, action: #selector(restartExperienceButton(_:)), for: .touchUpInside)
    }
    
    @objc private func restartExperienceButton(_ sender: UIButton) {
        restartExperienceHandler()
    }
    
    private func setupAddSolarSystemButton() {
        addSolarSystemButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addSolarSystemButton.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 0.6)
        addSolarSystemButton.layer.cornerRadius = 15
        addSolarSystemButton.isHidden = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        addSolarSystemButton.setImage(UIImage(systemName: "plus",withConfiguration: imageConfig), for: .normal)
        addSolarSystemButton.imageView?.tintColor = .white
    }
    
    private func setupSpinningButton() {
        spinButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        spinButton.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 0.6)
        spinButton.layer.cornerRadius = 15
        spinButton.isHidden = true
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        spinButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: imageConfig), for: .normal)
        spinButton.imageView?.tintColor = .white
        spinButton.addTarget(self, action: #selector(spinningButton(_:)), for: .touchUpInside)
    }
    
    @objc private func spinningButton(_ sender: UIButton) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .large)
        if isSpinnng {
            stopSpinning()
            spinButton.setImage(UIImage(systemName: "play.fill", withConfiguration: imageConfig), for: .normal)
        } else {
            startSpinning(root: sunNode)
            spinButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: imageConfig), for: .normal)
        }
    }
    
    private func stopSpinning() {
        isSpinnng = false
        sunNode.removeAllNodesActions()
    }
    
    private func startSpinning(root: PlanetNode) {
        isSpinnng = true
        
        for (index, child) in root.childNodes.enumerated() where index % 2 == 0 {
            switch index {
            case 2:
                // Mercury
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 12, sunTimeRotation: 10)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 4:
                // Venus
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 14, sunTimeRotation: 12)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 6:
                // Mars
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 16, sunTimeRotation: 14)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 8:
                // Jupiter
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 28, sunTimeRotation: 24)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 10:
                // Saturn
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 30, sunTimeRotation: 32)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 12:
                // Uranus
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 32, sunTimeRotation: 20)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 14:
                // Neptune
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 36, sunTimeRotation: 28)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            case 16:
                // Earth
                let (planetRotation, sunRotation) = resumePlanetRotation(planetTimeRotation: 18, sunTimeRotation: 16)
                child.runAction(planetRotation)
                if let aroundSun = child.childNodes.first {
                    aroundSun.runAction(sunRotation)
                }
            default:
                break
            }
        }
    }
    
    private func resumePlanetRotation(planetTimeRotation: Double, sunTimeRotation: Double) -> (SCNAction, SCNAction) {
        let planetRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: planetTimeRotation)
        let aroundSunRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: sunTimeRotation)
        let foreverPlanetRotation = SCNAction.repeatForever(planetRotation)
        let foreverAroundSunRotation = SCNAction.repeatForever(aroundSunRotation)
        return (foreverPlanetRotation, foreverAroundSunRotation)
    }
}
