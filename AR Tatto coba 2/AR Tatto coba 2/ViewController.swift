//
//  ViewController.swift
//  Tattoo Trace
//
//  Created by Kelvin Lukita on 19/05/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let arImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {return}
        
        configuration.trackingImages = arImages
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Checking if the planeAnchor exists
//        guard let anchor = anchor as? ARPlaneAnchor else { return }
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode); for anchor: ARAnchor {
        guard anchor is ARImageAnchor else { return }
            
        guard let container = sceneView.scene.rootNode.childNode(withName: "container9", recursively: false) else { return }
        container.removeFromParentNode()
        node.addChildNode(container)
        container.isHidden = false
    }
        
}


