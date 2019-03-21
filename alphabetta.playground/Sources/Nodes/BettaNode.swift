import SpriteKit

public class BettaNode: SKSpriteNode {
    
    // MARK: - Properties
    var loveLevel: LoveLevel = .empty
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Actions
    public func speak(conversationNumber speakNumber: Int, withDuration duration: TimeInterval, atPosition position: CGPoint ,completion: @escaping () -> ()) {
        // Create node and texture
        let texture = SKTexture(imageNamed: "Assets/Speak/speak\(speakNumber)")
        let speakNode = SKSpriteNode(texture: texture, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        // Set properties and add to alpha node
        speakNode.alpha = 0
        speakNode.position = position
        self.scene?.addChild(speakNode)
        
        // Apply animation and call completion
        let sequence = SKAction.sequence([SKAction.fadeIn(withDuration: 0.3), SKAction.wait(forDuration: duration)])
        
        speakNode.run(sequence) {
            speakNode.run(SKAction.fadeOut(withDuration: 0.3), completion: {
                speakNode.removeFromParent()
            })
            completion()
        }
    }
    
    public func showLoveLevel(completion: @escaping () -> () = { }) {
        // Create node
        var texture = SKTexture(imageNamed: "Assets/Scenario/\(self.loveLevel.rawValue)Love")
        let node = SKSpriteNode(texture: texture, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        
        node.position = CGPoint(x: self.position.x, y: self.position.y + 55)
        node.alpha = 0
        
        self.scene?.addChild(node)
        
        // Show
        let sequence = SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.3),
            SKAction.scale(to: 1.1, duration: 1),
            SKAction.scale(to: 1, duration: 1),
            SKAction.fadeOut(withDuration: 0.3)
            ])
        
        node.run(sequence) {
            node.removeFromParent()
            completion()
        }
    }
}

