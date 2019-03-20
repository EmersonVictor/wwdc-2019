import SpriteKit

public class CharacterNode: SKSpriteNode {
    
    // MARK: - Properties
    var loveLevel: LoveLevel = .empty
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // TODO: - Show love level
    // TODO: - Did play animation
}

