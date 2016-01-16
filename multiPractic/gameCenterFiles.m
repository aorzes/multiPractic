//
//  gameCenterFiles.m
//  gameCenter
//
//  Created by Anton Orzes on 07.07.2014..
//  Copyright (c) 2014. Anton Orzes. All rights reserved.
//

#import "gameCenterFiles.h"
#import "GameViewController.h"
#import "GameScene.h"


@interface gameCenterFiles () <GKGameCenterControllerDelegate> {




    BOOL _gameCenteFeaturesEnabled;



}

@end


@implementation gameCenterFiles


@synthesize gameCenterAvailable;

static gameCenterFiles *sharedControl = nil;
+(gameCenterFiles *)sharedInstance {

    if (!sharedControl) {
        sharedControl = [[gameCenterFiles alloc]init];
    }

    return sharedControl;


}




-(BOOL)isGameCenterAvailable {


    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice]systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch]);
    
    return (gcClass && osVersionSupported);

}

-(id)init {

    
    if ((self = [super init])) {
        
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
        
        
        
    }


    return self;



}



-(void)authenticationChanged {


    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        
        NSLog(@"Authentication Changed. UserAuthenticated");
        userAuthenticated = TRUE;
    }
    else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
    
    
        NSLog(@"Authentication Changed. User Not Authenticated");
        userAuthenticated = FALSE;
    
    
    }



}

-(void)authenticateLocalUser {

    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
        
        localPlayer.authenticateHandler = ^(UIViewController *gcvc,NSError *error){
        
        
            if (gcvc) {
                [self presentViewController:gcvc];
            }
        
            else {
                _gameCenteFeaturesEnabled = NO;
            
            }
        };
        
    }

    else if ([GKLocalPlayer localPlayer].authenticated == YES){
    
    
        _gameCenteFeaturesEnabled = YES;
    
    
    }
}


-(UIViewController*) getRootViewController {


    return [UIApplication sharedApplication].keyWindow.rootViewController;

}
-(void)presentViewController:(UIViewController*)gcvc {

    UIViewController *rootVC = [self getRootViewController];
    [rootVC presentViewController:gcvc animated:YES completion:nil];

}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {




}





@end
