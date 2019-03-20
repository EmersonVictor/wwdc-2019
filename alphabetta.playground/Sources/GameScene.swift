import Foundation
import SpriteKit
import UIKit

public class GameScene: SKScene {
    
    // MARK: - Nodes
    // Characters
    var alphaNode: AlphaNode!
    var bettaNode: BettaNode!
    // Objects
    var objectsContainer: ObjectsContainerNode!
    var rattle: ObjectNode!
    var flute: ObjectNode!
    var singBtn: SKSpriteNode!
    
    // MARK: - View initializer 
    override public func didMove(to view: SKView) {
        // Reload scene textures
        self.reloadTextures()
        
        // Remove user interaction
        self.isUserInteractionEnabled = false
        
        // Add conversation
        self.startConversation()
        
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
        self.rattle = self.childNode(withName: "rattle") as! ObjectNode
        self.rattle.texture = SKTexture(imageNamed: "Assets/Scenario/rattle")
        
        // Flute
        self.flute = self.childNode(withName: "flute") as! ObjectNode
        self.flute.texture = SKTexture(imageNamed: "Assets/Scenario/flute")
        
        /// Characters
        // Alpha
        self.alphaNode = self.childNode(withName: "alpha") as! AlphaNode
        self.alphaNode.texture = SKTexture(imageNamed: "Assets/Characters/alpha")
        
        // Betta
        self.bettaNode = self.childNode(withName: "betta") as! BettaNode
        self.bettaNode.texture = SKTexture(imageNamed: "Assets/Characters/betta")
    }
    
    // MARK: - Touch event
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Get touch location
            let touchLocation = touch.location(in: self)
            
            // Move alpha
            if touchLocation.x > 115 {
                self.alphaNode.walkTo(x: 115)
            } else {
                self.alphaNode.walkTo(x: touchLocation.x)
            }
            
            // Check if player touched objects
            let nodesInTouch = self.nodes(at: touchLocation)
            
            if nodesInTouch.contains(self.rattle) {
                // Touch in rattle
                self.didTouch(in: self.rattle)
                print("TODO: Update rattle hint timer")
            } else if nodesInTouch.contains(self.flute) {
                // Touch in flute
                self.didTouch(in: self.flute)
                print("TODO: Update flute hint timer")
            } else if nodesInTouch.contains(self.bettaNode) {
                self.playWithBetta()
            }
        }
    }
    
    // MARK: - Start initial conversation
    public func startConversation() {
        print("TODO: Conversation")
        self.isUserInteractionEnabled = true
        print("TODO: Timer para brinquedo")
    }
    
    
    // MARK: - Touch in object action
    public func didTouch(in object: ObjectNode) {
        object.userDidPlayed = true
        
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
        
        // Betta animation
        print("TODO: Betta animation")
        
        // Check if Betta played with all objects
        if self.flute.userDidPlayed && self.rattle.userDidPlayed {
            print("TODO: Show sign button")
        }
    }
    
    // MARK: - Sing button
    public func showSingButton() {
        print("TODO: Show sing button")
    }
    
    public func didTouchSingButton() {
        print("TODO: Alpha sing to betta")
        print("TODO: Heart animation")
        print("TODO: Last conversation")
    }
}
