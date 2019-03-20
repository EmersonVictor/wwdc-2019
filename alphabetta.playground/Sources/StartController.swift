import PlaygroundSupport
import SpriteKit
import UIKit

public class StartController: UIViewController {
    
    // MARK: - UIElements
    let filter = UIView(frame: CGRect(x:0 , y:0, width: 640, height: 332))
    let gameTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 377, height: 54))
    let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 198, height: 43))
    
    // MARK: - View initializer
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize view
        self.view = UIView(frame: CGRect(x:0 , y:0, width: 640, height: 332))
        
        // Initializer inteface
        self.loadInterface()
    }
    
    // MARK: - Setup view interface
    public func loadInterface() {
        let centerView = self.view.center
        
        // Background
        let background = UIImageView(image: UIImage(named: "Assets/Scenario/scenario")!)
        background.frame.size = CGSize(width: 640, height: 332)
        self.view.addSubview(background)
        
        // Filter
        self.filter.backgroundColor = .black
        self.filter.layer.opacity = 0.8
        self.view.addSubview(self.filter)
        
        // Game title
        self.gameTitle.center = CGPoint(x: centerView.x, y: centerView.y - 30)
        self.gameTitle.image = UIImage(named: "Assets/UI/title")
        self.view.addSubview(self.gameTitle)
        
        
        // Button
        self.startButton.center = CGPoint(x: centerView.x, y: centerView.y + 40)
        self.startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        self.startButton.setImage(UIImage(named: "Assets/UI/startBtn"), for: .normal)
        self.view.addSubview(self.startButton)
    }
    
    // MARK: - Start game action
    @objc public func startGame(sender: UIButton!) {
        // Animate button
        UIView.animate(withDuration: 0.15, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            sender.transform = CGAffineTransform.identity
        }
        
        // Remove folter, button and title
        UIView.animate(withDuration: 1.5, delay: 0.15, options: .curveLinear, animations: {
            self.gameTitle.layer.opacity = 0
            self.startButton.layer.opacity = 0
            self.filter.layer.opacity = 1
        }) { _ in
            // Load the SKScene from 'GameScene.sks'
            let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 332))

            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                sceneView.presentScene(scene)
            }
            
            // Present SKView
            PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
            
        }
    }
}


