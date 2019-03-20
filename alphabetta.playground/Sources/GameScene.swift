import Foundation
import SpriteKit
import UIKit

public class GameScene: SKScene {
    
    // MARK: - Nodes
    // Characters
    var alphaNode: CharacterNode!
    var bettaNode: CharacterNode!
    // Objects
    var objectsContainer: ObjectsContainerNode!
    var rattle: SKSpriteNode!
    var flute: SKSpriteNode!
    var singBtn: SKSpriteNode!
    
    // MARK: - Variables
    var bettaPlayTimes = 0 {
        didSet {
            if self.bettaPlayTimes == 2 {
                // TODO: - Show sing button
            }
        }
    }
    
    // MARK: - View initializer 
    override public func didMove(to view: SKView) {
        // Reload scene textures
        self.reloadTextures()
        
        // Setup custom font
//        let fontURL = Bundle.main.url(forResource: "Assets/Font/PaytoneOne", withExtension: "ttf") as! CFURL
//        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
    }
    
    // MARK: - Reload scene textures
    public func reloadTextures() {
        //// Scenario
        let scenario = self.childNode(withName: "scenario") as! SKSpriteNode
        scenario.texture = SKTexture(imageNamed: "Assets/Scenario/scenario")
        
        /// Objects
        // Objects container
        self.objectsContainer = self.childNode(withName: "objectsContainer") as! ObjectsContainerNode
        self.objectsContainer.texture = SKTexture(imageNamed: "Assets/UI/objectsContainer")
        
        // Rattle
        self.rattle = self.childNode(withName: "rattle") as! SKSpriteNode
        self.rattle.texture = SKTexture(imageNamed: "Assets/Scenario/rattle")
        
        // Flute
        self.flute = self.childNode(withName: "flute") as! SKSpriteNode
        self.flute.texture = SKTexture(imageNamed: "Assets/Scenario/flute")
        
        /// Characters
        // Alpha
        self.alphaNode = self.childNode(withName: "alpha") as! CharacterNode
        self.alphaNode.texture = SKTexture(imageNamed: "Assets/Characters/Alpha/alpha")
        
        // Betta
        self.bettaNode = self.childNode(withName: "betta") as! CharacterNode
        self.bettaNode.texture = SKTexture(imageNamed: "Assets/Characters/Betta/betta")
    }
    
    // MARK: - Touch event
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Get touch location
            let touchLocation = touch.location(in: self)
            
            // Create move action
            var moveAction: SKAction
            if touchLocation.x > 115 {
                moveAction = SKAction.moveTo(x: 115, duration: 0.5)
            } else {
                moveAction = SKAction.moveTo(x: touchLocation.x, duration: 0.5)
            }
            
            self.alphaNode.run(moveAction)
            
            // Check if player touched objects
            let nodesInTouch = self.nodes(at: touchLocation)
            
            if nodesInTouch.contains(self.rattle) {
                // Touch in rattle
                self.didTouch(in: self.rattle)
                self.bettaPlayTimes += 1
            } else if nodesInTouch.contains(self.flute) {
                // Touch in flute
                self.didTouch(in: self.flute)
                self.bettaPlayTimes += 1
            } else if nodesInTouch.contains(self.bettaNode) {
                self.playWithBetta()
            }
        }
    }
    
    // MARK: - Touch in object action
    public func didTouch(in object: SKSpriteNode) {
        if !self.objectsContainer.hasObjectInside {
            self.objectsContainer.add(newObject: object)
        }
    }
    
    // MARK: - Play with betta
    public func playWithBetta() {
        // Remove object of container
        if self.objectsContainer.hasObjectInside {
            self.objectsContainer.removeObjectInside()
        }
        
        // Run betta animation
        // TODO: - Betta animation
    }
}
