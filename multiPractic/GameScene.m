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
    
    mlaz1 = [SKSpriteNode spriteNodeWithImageNamed:@"mlaz"];
    mlaz1.size = CGSizeMake(25, 35);
    mlaz1.zPosition = -1;
    mlaz1.alpha = 0;
    mlaz1.position = CGPointMake(0, -sb1.size.height/2-12);
    [sb1 addChild:mlaz1];
    
    SKAction *upaliMotor = [SKAction fadeInWithDuration:0.1];
    SKAction *ugasiMotor = [SKAction fadeOutWithDuration:0.1];
    motor = [SKAction sequence:@[upaliMotor,ugasiMotor]];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (location.y>sb1.position.y) {
            [sb1.physicsBody applyImpulse:CGVectorMake(0, 5)];
            [mlaz1 runAction:motor];
            
        }
        else
        {
            [sb1.physicsBody applyImpulse:CGVectorMake(0, -5)];
        }
        
        
    }
}

/*
- (void)showLeaderboardOnViewController:(UIViewController*)viewController
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil) {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardIdentifier = @"globalScore";
        
        [viewController presentViewController: gameCenterController animated: YES completion:nil];
    }
}




- (void) presentLeaderboards {
    GKGameCenterViewController* gameCenterController = [[GKGameCenterViewController alloc] init];
    gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
    gameCenterController.gameCenterDelegate = self;
    
    UIViewController *vc=self.view.window.rootViewController;
    [vc presentViewController:gameCenterController animated:YES completion:nil];
    
    
}




- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
*/

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
