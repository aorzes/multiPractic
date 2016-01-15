//
//  GameScene.m
//  multiPractic
//
//  Created by Anton Orzes on 15.01.2016..
//  Copyright (c) 2016. Anton Orzes. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake(0, -0.5);
    
    SKShapeNode *gore = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.size.width, 10)];
    gore.position = CGPointMake(self.size.width/2, self.size.height-5);
    gore.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(self.size.width, 10)];
    gore.physicsBody.dynamic = NO;
    [self addChild:gore];
    
    SKShapeNode *dolje = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.size.width, 10)];
    dolje.position = CGPointMake(self.size.width/2, 5);
    dolje.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(self.size.width, 10)];
    dolje.physicsBody.dynamic = NO;
    [self addChild:dolje];
    
    sb1 = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    sb1.size = CGSizeMake(50, 50);
    sb1.zPosition = 1;
    sb1.position = CGPointMake(self.size.width/3, 70);
    sb1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sb1.size];
    sb1.physicsBody.affectedByGravity = YES;
    [self addChild:sb1];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (location.y>sb1.position.y) {
            [sb1.physicsBody applyImpulse:CGVectorMake(0, 5)];
        }
        else
        {
            [sb1.physicsBody applyImpulse:CGVectorMake(0, -5)];
        }
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
