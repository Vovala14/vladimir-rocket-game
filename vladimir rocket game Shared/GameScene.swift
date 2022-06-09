//
//  GameScene.swift
//  vladimir rocket game Shared
//
//  Created by Vladimir Lavrik on 07/06/2022.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "myrocket")
    let bullet = SKSpriteNode(imageNamed: "arrow")
    let bulletsound = SKAction.playSoundFileNamed("lazer", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        let sky = SKSpriteNode(imageNamed: "sky")
        sky.size = self.size
        sky.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        sky.zPosition = 0
        self.addChild(sky)
        
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        player.zPosition = 2
        self.addChild(player)
    
    }
    
    func firebullet(){
        let bullet = SKSpriteNode(imageNamed: "arrow")
            bullet.setScale(1)
            bullet.zPosition = 1
            bullet.position = player.position
            addChild(bullet)

        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1.0)
            let deleteBullet = SKAction.removeFromParent()
            let bulletSequence = SKAction.sequence([bulletsound, moveBullet, deleteBullet])
            bullet.run(bulletSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firebullet()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointoftouch = touch.location(in: self)
            let previouspointoftouch = touch.previousLocation(in: self)
            
            let amountdragged = pointoftouch.x - previouspointoftouch.x
            player.position.x += amountdragged
        }
    }
}
