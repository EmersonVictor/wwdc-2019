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
        if self.bettaNode.loveLevel != .two {
            // Move alpha
            self.isUserInteractionEnabled = false
            
            let alphaNewPosition = touchLocation.x > 120 ? 120 : touchLocation.x
            self.alphaNode.walkTo(x: alphaNewPosition) {
                // Check if player touched objects
                let nodesInTouch = self.nodes(at: touchLocation)
                
                if nodesInTouch.contains(self.rattle) {
                    // Touch in rattle
                    self.didTouch(in: self.rattle)
                } else if nodesInTouch.contains(self.flute) {
                    // Touch in flute
                    self.didTouch(in: self.flute)
                } else if nodesInTouch.contains(self.bettaNode) {
                    self.playWithBetta()
                }

                self.isUserInteractionEnabled = true
            }
        } else {
            // Check if player touched objects
            let nodesInTouch = self.nodes(at: touchLocation)
            
            if nodesInTouch.contains(self.singBtn) {
                self.didTouchSingButton()
            }
        }
    }
    
    // MARK: - Touch in object action
    public func didTouch(in object: ObjectNode) {
        if !self.objectsContainer.hasObjectInside {
            object.userDidPlayed = true
            self.objectsContainer.add(newObject: object)
        }
    }
    
    // MARK: - Touch in sing button action
    public func didTouchSingButton() {
        self.alphaNode.sing {
            self.bettaNode.loveLevel = .full
            self.bettaNode.showLoveLevel(completion: {
                self.alphaNode.happinessLevel = .happy
                self.finishScene()
            })
        }
        self.singBtn.removeFromParent()
    }
}
