//
//  SolarSystemViewController+CoachingOverlay.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import UIKit
import ARKit

/// - Tag: CoachingOverlayViewDelegate
extension SolarSystemViewController: ARCoachingOverlayViewDelegate {
    
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
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(coachingOverlay)
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: sceneView.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: sceneView.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: sceneView.heightAnchor)
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
