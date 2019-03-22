import SpriteKit

public class ObjectsContainerNode: SKSpriteNode {
    
    // MARK: - Properties
    private(set) var numberOfInteractedObjects: Int = 0
    
    var objectInside: SKSpriteNode? {
        didSet {
            // Animation
            if let _ = self.objectInside {
                self.run(SKAction.fadeIn(withDuration: 0.3))
            } else {
                self.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
            }
        }
    }
    
    var hasObjectInside: Bool {
        get {
            if let _ = self.objectInside {
                return true
            }
            return false
        }
    }
    
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Add new object
    func add(newObject object: SKSpriteNode) {
        // Add object to container
        self.objectInside = object
        self.numberOfInteractedObjects += 1
        
        // Remove object
        object.run(SKAction.fadeOut(withDuration: 0.05)) {
            // Show at object inside
            object.removeFromParent()
            object.zRotation = 0
            object.position = CGPoint(x: self.position.x, y: self.position.y + 18)
            self.scene?.addChild(object)
            object.run(SKAction.fadeIn(withDuration: 0.4))
        }
    }
    
    // MARK: - Remove object
    public func removeObjectInside() {
        self.objectInside?.run(SKAction.fadeOut(withDuration: 0.3), completion: {
            self.removeAllChildren()
        })
        self.objectInside = nil
        
    }
}
