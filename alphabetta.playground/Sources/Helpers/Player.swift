import SpriteKit

public class Player {
    static let shared: Player = Player()
    
    // MARK: - Initializers
    private init() {
    }
    
    // MARK: - Player actions
    public func playAudio(fileNamed audio: String, in scene: SKScene, withVolume volume: Float, withName name: String = "") {
        let audioNode = SKAudioNode(fileNamed: audio)
        audioNode.isPositional = false
        audioNode.autoplayLooped = true
        audioNode.name = name
        audioNode.run(SKAction.changeVolume(to: volume, duration: 0))
        
        scene.addChild(audioNode)
    }
    
    public func playSfx(fileName audio: String, in node: SKSpriteNode, completion: @escaping () -> () = {}) {
        let action = SKAction.playSoundFileNamed(audio, waitForCompletion: false)
        node.run(action) {
            completion()
        }
    }
    
    public func removeAudio(withName name: String, from scene: SKScene, withFadeDuration duration: TimeInterval) {
        let audio = scene.childNode(withName: name) as! SKAudioNode
        audio.run(SKAction.changeVolume(to: 0, duration: duration)) {
            audio.removeFromParent()
        }
    }
}
