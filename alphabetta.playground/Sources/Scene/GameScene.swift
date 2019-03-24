import SpriteKit

public class GameScene: SKScene {
    // MARK: - Nodes
    // Characters
    var alphaNode: AlphaNode!
    var bettaNode: BettaNode!
    // Toys
    var objectsContainer: ObjectsContainerNode!
    var dice: ObjectNode!
    var flute: ObjectNode!
    var genius: ObjectNode!
    var rattle: ObjectNode!
    // Sing button
    var singBtn: SKSpriteNode!
    // Box
    var box: SKSpriteNode!
    
    // MARK: - Interface initializer
    override public func didMove(to view: SKView) {
        // Reload scene textures
        self.reloadTextures()
        
        // Add conversation
        self.startInitialConversation()
        
        // Play background
        Player.shared.playAudio(fileNamed: "Assets/Sounds/Pizzicato Polka Inspirations for PlayGround", in: self, withVolume: 0.2, withName: "background")
    }
    
    // Reload scene textures
    public func reloadTextures() {
        //// Scenario
        let scenario = self.childNode(withName: "scenario") as! SKSpriteNode
        scenario.texture = SKTexture(imageNamed: "Assets/Scenario/scenario")
        
        let table = self.childNode(withName: "table") as! SKSpriteNode
        table.texture = SKTexture(imageNamed: "Assets/Scenario/table")
        
        /// Objects
        // Objects container
        self.objectsContainer = self.childNode(withName: "objectsContainer") as! ObjectsContainerNode
        self.objectsContainer.texture = SKTexture(imageNamed: "Assets/UI/objectsContainer")
        
        // Box
        self.box = childNode(withName: "box") as! SKSpriteNode
        self.box.texture = SKTexture(imageNamed: "Assets/Scenario/box")
        
        // Dice
        self.dice = self.childNode(withName: "dice") as! ObjectNode
        self.dice.texture = SKTexture(imageNamed: "Assets/Scenario/dice")
        
        // Flute
        self.flute = self.childNode(withName: "flute") as! ObjectNode
        self.flute.texture = SKTexture(imageNamed: "Assets/Scenario/flute")
        
        // Genius
        self.genius = self.childNode(withName: "genius") as! ObjectNode
        self.genius.texture = SKTexture(imageNamed: "Assets/Scenario/genius")
        
        // Rattle
        self.rattle = self.childNode(withName: "rattle") as! ObjectNode
        self.rattle.texture = SKTexture(imageNamed: "Assets/Scenario/rattle")
        
        /// Characters
        // Alpha
        self.alphaNode = self.childNode(withName: "alpha") as! AlphaNode
        self.alphaNode.texture = SKTexture(imageNamed: "Assets/Characters/Alpha/sadWalk/sad-walk0")
        
        // Betta
        self.bettaNode = self.childNode(withName: "betta") as! BettaNode
        self.bettaNode.texture = SKTexture(imageNamed: "Assets/Characters/Betta/betta")
    }
    
    // MARK: - Start initial conversation
    public func startInitialConversation() {
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
                    self.showInstruction(withNumber: 1)
                })
            })
        }
    }
    
    // MARK: - Show intructions for user
    public func showInstruction(withNumber number: Int) {
        let texture = SKTexture(imageNamed: "Assets/Speak/instruction\(number)")
        let instruction = SKSpriteNode(texture: texture, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        
        instruction.alpha = 0
        instruction.position = CGPoint(x: 143, y: 130)
        
        self.addChild(instruction)
        
        let sequence = SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.3),
            SKAction.wait(forDuration: 6),
            SKAction.fadeOut(withDuration: 0.3)
            ])
        
        instruction.run(sequence) {
            instruction.removeFromParent()
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
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Last conversation and finish
    public func finishScene() {
        self.isUserInteractionEnabled = false
        
        let bettaSpeakPosition = CGPoint(x: self.bettaNode.position.x + 80, y: self.bettaNode.position.y + 60)
        self.bettaNode.speak(conversationNumber: 5, withDuration: 3, atPosition: bettaSpeakPosition, completion: {
            
            let alphaSpeakPosition = CGPoint(x: self.alphaNode.position.x - 90, y: self.alphaNode.position.y + 60)
            self.alphaNode.speak(conversationNumber: 6, withDuration: 3, atPosition: alphaSpeakPosition, completion: {
                self.run(SKAction.fadeOut(withDuration: 3))
                Player.shared.removeAudio(withName: "background", from: self, withFadeDuration: 3)
            })
        })
    }
}
