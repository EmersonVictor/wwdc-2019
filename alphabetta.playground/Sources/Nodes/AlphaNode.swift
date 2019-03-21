import Foundation
import SpriteKit

public class AlphaNode: SKSpriteNode {
    
    // MARK: - Animation sprites
    var sadTextures: [SKTexture] = []
    var normalTextures: [SKTexture] = []
    var fineTextures: [SKTexture] = []
    
    // MARK: - Properties
    var happinessLevel: HappinessLevel = .sad {
        didSet {
            print("TODO: #1 Change sprite acroding to happinness level")
            print("Animate happiness level changing")
        }
    }
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadSprites()
    }
    
    // MARK: - Helpers
    public func loadSprites() {
        for i in 0...3 {
            // Sad
            self.sadTextures.append(SKTexture(imageNamed: "Assets/Characters/alphaSadWalk/sad-walk\(i)"))
            
            // Normal
            self.normalTextures.append(SKTexture(imageNamed: "Assets/Characters/alphaNormalWalk/normal-walk\(i)"))
            
            // Fine
            self.fineTextures.append(SKTexture(imageNamed: "Assets/Characters/alphaFineWalk/fine-walk\(i)"))
        }
    }
    
    // MARK: - Actions
    public func walkTo(x: CGFloat, completion: @escaping () -> ()) {
        // Actions and animation
        let distance = Double(abs(self.position.x - x))
        let moveAction = SKAction.moveTo(x: x, duration: 0.01 * distance)
        var spritesAnimaton: SKAction
        
        switch self.happinessLevel {
        case .sad:
            spritesAnimaton = SKAction.animate(with: self.sadTextures, timePerFrame: 0.2, resize: false, restore: false)
        case .normal:
            spritesAnimaton = SKAction.animate(with: self.normalTextures, timePerFrame: 0.2, resize: false, restore: false)
        case .fine:
            spritesAnimaton = SKAction.animate(with: self.fineTextures, timePerFrame: 0.2, resize: false, restore: false)
        default:
            spritesAnimaton = SKAction.animate(with: self.sadTextures, timePerFrame: 0.2, resize: false, restore: false)
        }
        
        self.run(SKAction.repeatForever(spritesAnimaton))
        self.run(moveAction) {
            self.removeAllActions()
            completion()
        }
    }
    
    public func speak(conversationNumber speakNumber: Int, withDuration duration: TimeInterval, atPosition position: CGPoint, completion: @escaping () -> ()) {
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
    
    public func sing(completion: @escaping () -> ()) {
        print("TODO: #1 Sing animation")
    }
}
