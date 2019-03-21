import SpriteKit

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
        
        // Add conversation
        self.startConversation()
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
        self.alphaNode.texture = SKTexture(imageNamed: "Assets/Characters/sadWalk/sad-walk0")
        
        // Betta
        self.bettaNode = self.childNode(withName: "betta") as! BettaNode
        self.bettaNode.texture = SKTexture(imageNamed: "Assets/Characters/betta")
    }
    
    // MARK: - Start initial conversation
    public func startConversation() {
        // Remove user interaction
        self.isUserInteractionEnabled = false
        
        // Mom speak
        let texture = SKTexture(imageNamed: "Assets/Speak/speak1")
        let momSpeak = SKSpriteNode(texture: texture, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        momSpeak.alpha = 0
        momSpeak.position = CGPoint(x: -250, y: 50)
        self.addChild(momSpeak)
        
        let sequence = SKAction.sequence([
            SKAction.wait(forDuration: 3),
            SKAction.fadeIn(withDuration: 0.3),
            SKAction.wait(forDuration: 4)])
        
        momSpeak.run(sequence) {
            momSpeak.run(SKAction.fadeOut(withDuration: 0.3), completion: {
                momSpeak.removeFromParent()
            })
            
            // Alpha speak
            let alphaSpeakPosition = CGPoint(x: self.alphaNode.position.x - 80, y: self.alphaNode.position.y + 100)
            self.alphaNode.speak(conversationNumber: 2, withDuration: 3, atPosition: alphaSpeakPosition, completion: {
                // Betta speak
                let bettaSpeakPosition = CGPoint(x: self.bettaNode.position.x - 80, y: self.bettaNode.position.y + 60)
                self.bettaNode.speak(conversationNumber: 3, withDuration: 4, atPosition: bettaSpeakPosition, completion: {
                    self.isUserInteractionEnabled = true
                })
            })
        }
    }
    
    // MARK: - Play with betta
    public func playWithBetta() {
        // Remove object of container
        if self.objectsContainer.hasObjectInside {
            self.objectsContainer.removeObjectInside()
        }
        
        // Check if Betta played with all objects
        if self.flute.userDidPlayed && self.rattle.userDidPlayed {
            self.bettaNode.loveLevel = .two
        
            self.bettaNode.showLoveLevel {
                self.alphaNode.happinessLevel = .fine
                let bettaSpeakPosition = CGPoint(x: self.bettaNode.position.x + 80, y: self.bettaNode.position.y + 60)
                self.bettaNode.speak(conversationNumber: 4, withDuration: 5, atPosition: bettaSpeakPosition) {
                    self.showSingButton()
                }
            }
        } else if self.flute.userDidPlayed || self.rattle.userDidPlayed {
            self.bettaNode.loveLevel = .one
            self.bettaNode.showLoveLevel {
                self.alphaNode.happinessLevel = .normal
            }
        } else {
            self.bettaNode.showLoveLevel()
        }
    }
    
    // MARK: - Sing button
    public func showSingButton() {
        let texture = SKTexture(imageNamed: "Assets/UI/musicBtn")
        self.singBtn = SKSpriteNode(texture: texture, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        
        self.singBtn.position = CGPoint(x: self.alphaNode.position.x - 50, y: self.alphaNode.position.y)
        self.singBtn.alpha = 0
        
        self.addChild(self.singBtn)
        self.singBtn.run(SKAction.fadeIn(withDuration: 0.3))
    }
    
    // MARK: - Last conversation and finish
    public func finishScene() {
        self.isUserInteractionEnabled = false
        print("TODO: #1 Last conversation")
    }
}
