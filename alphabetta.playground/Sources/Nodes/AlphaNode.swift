import Foundation
import SpriteKit

public class AlphaNode: SKSpriteNode {
    
    // MARK: - Properties
    var happinessLevel: HappinessLevel = .sad {
        didSet {
            print("TODO: Change sprite acroding to happinness level")
            print("Animate happiness level changing")
        }
    }
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Actions
    public func walkTo(x: CGFloat) {
        print("TODO: Walk animation")
    }
    
    public func speakConversation(number: Int) {
        print("TODO: Speak conversation number")
    }
}
