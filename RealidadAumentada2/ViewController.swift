import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let toque = touches.first else { return }
        let objetosAR = sceneView.hitTest(toque.location(in: sceneView), types: [.featurePoint])
        guard let ultimoObjeto = objetosAR.last else { return }
        let transformado = ultimoObjeto.worldTransform // trae las corrdenadas X, Y, Z
        print(transformado)
        
        let punto3D = SCNVector3(transformado[3][0], transformado[3][1], transformado[3][2])
        print(punto3D)
        
        agregarEsfera(punto: punto3D)
    }
    
    func agregarEsfera(punto: SCNVector3) {
        let esfera = SCNSphere(radius: 0.01)
        let nodoEsfera = SCNNode(geometry: esfera)
        nodoEsfera.position = punto
    }

    // MARK: - ARSCNViewDelegate
    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
    }

}
