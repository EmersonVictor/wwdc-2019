import SpriteKit

public class ObjectNode: SKSpriteNode {
    
    // MARK: - Properties
    var userDidPlayed: Bool = false
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Give a hint
    public func giveHint() {
        print("TODO: Give a hint")
    }
}
