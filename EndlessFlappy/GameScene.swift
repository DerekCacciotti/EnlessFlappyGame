//
//  GameScene.swift
//  EndlessFlappy
//
//  Created by Derek Cacciotti on 6/20/15.
//  Copyright (c) 2015 Derek Cacciotti. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var mainPipe: SKSpriteNode = SKSpriteNode()
    
    var spacebetweenpipes:Float = 90 // number of pixels between each space
    var lastOffset: Float = 0
    var maxnum:Float = 175
    var minnum:Float = -100
    
    var pipes:[SKSpriteNode] = []
    
    override func didMoveToView(view: SKView)
    {
        mainPipe = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(view.bounds.size.width / 6, 480))
        
        
        
        // put pipes on screen
        createPipes(0)
    }
    
    func createPipes(offs:Float)
    {
       let offset = offs - (spacebetweenpipes / 2)
        let pipebottom = (mainPipe as SKSpriteNode).copy() as! SKSpriteNode
        let pipeTop = (mainPipe as SKSpriteNode).copy() as! SKSpriteNode
        
        let xx = Float(view!.bounds.size.width) // casted to a float
        
       self.setBottomPosition(pipebottom, x: xx, y: offset)
        self.setTopPosition(pipeTop, x: xx, y: offset + spacebetweenpipes)
        
        // adding pipes to pipes array so they can be added as the scene moves along
        pipes.append(pipebottom)
        pipes.append(pipeTop)
        
        
        self.addChild(pipebottom)
        self.addChild(pipeTop)
        
        
        
        
    }
    
    func setBottomPosition(node:SKSpriteNode, x:Float, y:Float)
    {
        let xpos = (Float(node.size.width) / 2) + x
        let ypos = Float(self.view!.bounds.size.height) / 2 - (Float(node.size.height) / 2) + y
        
        node.position.x = CGFloat(xpos)
        node.position.y = CGFloat(ypos)
    }
    
    func setTopPosition(node:SKSpriteNode,x:Float, y:Float)
    {
        let xx = (Float(node.size.width) / 2) + x
        let yy = Float(self.view!.bounds.size.height) / 2 + (Float(node.size.height) / 2) + y
        
        node.position.x = CGFloat(xx)
        node.position.y = CGFloat(yy)
    }
    
    func randomOffset() -> Float
    {
         let max = maxnum - lastOffset
        let min = minnum - lastOffset
        var rand: Float = Float(arc4random() % 61) + 40
        var randBool: Float = Float(arc4random() % 31) + 1
        
        if randBool % 2 == 0
        {
            var tempnum = lastOffset + rand
            if tempnum > maxnum
            {
                tempnum = maxnum - randBool
            }
            
            rand = tempnum
        }
        
        else
        {
            var tempnum = lastOffset - rand
            if tempnum < minnum
            {
                tempnum = minnum + rand
            }
            
            rand = tempnum
        }
        
        lastOffset = rand
        
        return rand
        
        
        }// end of func
    
    
    
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        }
   
    override func update(currentTime: CFTimeInterval) {
        for (var i = 0; i < pipes.count; i++)
        {
            let pipe = pipes[i]
            pipe.position.x -= 1
            
            if i == pipes.count - 1
            {
                if pipe.position.x < self.view!.bounds.width - pipe.size.width * 2.0
                {
                    self.createPipes(self.randomOffset())
                }
            }
        }
        /* Called before each frame is rendered */
    }
}
