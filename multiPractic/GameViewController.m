//
//  GameViewController.m
//  multiPractic
//
//  Created by Anton Orzes on 15.01.2016..
//  Copyright (c) 2016. Anton Orzes. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@interface GameViewController ()<gameCenterFilesDelegate>




@end

@implementation GameViewController

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerAuthenticated) name:localPlayerIsAuthenticated object:nil];
    

}

-(void)playerAuthenticated{

    [[gameCenterFiles sharedGameKitHelper]findMatchWithMinPlayers:2 maxPlayers:2 viewControllelr:self delegate:self];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
-(void)match:(GKMatch *)match didReceiveData:(NSData *)data fromRemotePlayer:(GKPlayer *)player{

}
-(void)matchStarted{

}
-(void)mathcEnded{

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene nodeWithFileNamed:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //ovo treba za velicinu
    scene = [GameScene sceneWithSize:skView.bounds.size];
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
