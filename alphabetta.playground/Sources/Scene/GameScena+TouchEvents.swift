import SpriteKit

extension GameScene {
    // MARK: - Touches event
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Get touch location
            let touchLocation = touch.location(in: self)
            self.didTouch(at: touchLocation)
        }
    }
    
    // MARK: - Touch handler
    public func didTouch(at touchLocation: CGPoint) {
        let touchedNodes = nodes(at: touchLocation)
        
        // Move alpha
        self.isUserInteractionEnabled = false
        
        // Walk condition
        if self.bettaNode.loveLevel < 4 {
            let alphaNewPosition = touchLocation.x > 120 ? 120 : touchLocation.x
            self.alphaNode.walkTo(x: alphaNewPosition) {
                // Check if interaction event occured
                if touchedNodes.contains(self.dice) {
                    self.didInteract(withObject: self.dice)
                    
                } else if touchedNodes.contains(self.flute) {
                    self.didInteract(withObject: self.flute)
                    
                } else if touchedNodes.contains(self.genius) && !(touchedNodes.contains(self.box)) {
                    self.didInteract(withObject: self.genius)
                    
                } else if touchedNodes.contains(self.rattle) {
                    self.didInteract(withObject: self.rattle)
                    
                } else if touchedNodes.contains(self.bettaNode) {
                    self.didInteractWithBetta()
                    
                } else if touchedNodes.contains(self.box) {
                    if self.objectsContainer.numberOfInteractedObjects >= 3 {
                       self.didInteractWithBox()
                    }
                }
            }
        } else {
            // Check if user interact with sing button
            if touchedNodes.contains(self.singBtn) {
                self.didInteractWithSingButton()
            }
        }
        
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Touch especific interaction
    // Object interaction
    public func didInteract(withObject object: ObjectNode) {
        if !self.objectsContainer.hasObjectInside {
            Player.shared.playSfx(fileName: "Assets/Sounds/Plunky.mp3", in: self.objectsContainer)
            object.userDidPlayed = true
            self.objectsContainer.add(newObject: object)
        }
    }
    
    // Betta interaction
    public func didInteractWithBetta() {
        // Remove object of container
        if self.objectsContainer.hasObjectInside {
            self.objectsContainer.removeObjectInside()
            self.bettaNode.loveLevel += 1
            self.bettaNode.showLoveLevel()
            
            // Change alpha happinness according to number of objects played
            switch self.objectsContainer.numberOfInteractedObjects {
            case 2:
                self.alphaNode.happinessLevel = .normal
                self.showInstruction(withNumber: 2)
                return
            case 3:
                self.showInstruction(withNumber: 3)
                
                return
            case 4:
                self.alphaNode.happinessLevel = .fine
                self.isUserInteractionEnabled = false
                
                // Betta speak and show sing button
                self.run(SKAction.wait(forDuration: 2.5)) {
                    let bettaSpeakPosition = CGPoint(x: self.bettaNode.position.x + 80, y: self.bettaNode.position.y + 60)
                    self.bettaNode.speak(conversationNumber: 4, withDuration: 5, atPosition: bettaSpeakPosition) {
                        self.showSingButton()
                    }
                }
                
                return
            default:
                return
            }
        } else {
            self.bettaNode.showLoveLevel()
        }
    }
    
    // Box interaction
    public func didInteractWithBox() {
        if self.objectsContainer.numberOfInteractedObjects >= 3 {
            let moveAction = SKAction.moveTo(x: -18, duration: 2)
            self.box.run(moveAction) {
                self.box.isUserInteractionEnabled = false
            }
        }
    }
    
    // Sing button interaction
    public func didInteractWithSingButton() {
        self.alphaNode.sing {
            self.bettaNode.loveLevel += 1
            self.bettaNode.showLoveLevel(completion: {
                self.alphaNode.happinessLevel = .happy
                self.finishScene()
            })
        }
        
        self.singBtn.removeFromParent()
    }
}
