import SpriteKit

public class BettaNode: SKSpriteNode {
    
    // MARK: - Properties
    var loveLevel: LoveLevel = .empty
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Actions
    public func speakConversation(number: Int) {
        print("TODO: Speak conversation number")
    }
    
    public func showLoveLevel() {
        print("TODO: Show love level")
    }
}

