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
    var gamearea: CGRect
    

    
    override init(size: CGSize) {
        
        let maxaspectratio: CGFloat = 16.0/9.0
        let playablewith = size.height / maxaspectratio
        let margin = (size.width - playablewith) / 2
        gamearea = CGRect(x: margin, y: 0, width: playablewith, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() ->CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random( min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
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
        
        
        startnewlevel()
        
    }
        
    func startnewlevel(){

        let spwan = SKAction.runblock(spawnenemy)
        let waitTOspwan = SKAction.waitforduration(1)
        let = spwansequence = SKAction.sequence([spwan, waitTOspwan])
        let spwanforever = SKAction.repeatactionforever(spwansequence)
        self.runaction(spwanforever)

    }
    
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
    
    
    func spawnenemy(){
        
        let randomXstart = random(min: gamearea.minX ,max: gamearea.maxX)
        
        let randomXend = random(min: gamearea.minX, max: gamearea.maxX)
        
        let startpoint = CGPoint(x: randomXstart, y: self.size.height * 1.2)
        
        let endpoint = CGPoint(x: randomXend, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyrocket")
        enemy.setScale(1)
        enemy.position = startpoint
        enemy.zPosition = 2
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endpoint, duration: 1.5)
        
        let deleteEnemy = SKAction.removeFromParent()
        
        let EnemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(EnemySequence)
        
        enemy.runaction(EnemySequence)

        let dx = endpoint.x - startpoint.x 
        let dy = endpoint.y - startpoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zPosition = amountToRotate
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
            
            if player.position.x > gamearea.maxX - player.size.width/2{
                player.position.x = gamearea.maxX - player.size.width/2
            }
            
            if player.position.x < gamearea.minX + player.size.width/2{
                player.position.x = gamearea.minX + player.size.width/2
                
                
            
            }
        }
    }
}
