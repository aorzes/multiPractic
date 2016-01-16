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

NSString *const localPlayerIsAuthenticated = @"local_player_authenticated";


@interface gameCenterFiles () {
  BOOL _gameCenteFeaturesEnabled;
}


@end



@implementation gameCenterFiles
{
    
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    
    BOOL _enableGameCenter;
    BOOL _matchStarted;
    
    
}



@synthesize gameCenterAvailable;

static gameCenterFiles *sharedControl = nil;


+(gameCenterFiles *)sharedInstance {

    if (!sharedControl) {
        sharedControl = [[gameCenterFiles alloc]init];
    }

    return sharedControl;


}

/*
+(instancetype)sharedGameKitHelper{

    static gameCenterFiles *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[gameCenterFiles alloc]init];
    });
    return sharedGameKitHelper;
    
}
 */

-(void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];

}

-(void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error{
    [viewController dismissViewControllerAnimated:YES completion:nil];

}

-(void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match{

    [viewController dismissViewControllerAnimated:YES completion:nil];
    self.match = match;
    match.delegate = self;
    
    if (!_matchStarted && match.expectedPlayerCount == 0) {
        
        NSLog(@"ready to start match");
        
        
    }

}

-(void)match:(GKMatch *)match didReceiveData:(NSData *)data fromRemotePlayer:(GKPlayer *)player{
    if (_match != match) {
        
        return;
        
    }
    
    [_delegate match:match didReceiveData:data fromRemotePlayer:player];
    
    
    
}

-(void)match:(GKMatch *)match player:(GKPlayer *)player didChangeConnectionState:(GKPlayerConnectionState)state{
    if (_match != match) {
        return;
    }
    switch (state) {
        case 0:
        GKPlayerStateConnected:
            NSLog(@"player connected");
            
            if (_matchStarted && match.expectedPlayerCount == 0) {
                
                NSLog(@"ready to start match");
                
            }
            break;
            case 2:
        GKPlayerStateDisconnected:
            NSLog(@"player disconected");
            _matchStarted = NO;
            [_delegate mathcEnded];
            break;
            
        default:
            break;
    }
    



}

- (void)match:(GKMatch *)match connectionWithPlayerFailed:(NSString *)playerID withError:(NSError *)error {
    if (_match != match) return;
    
    NSLog(@"Failed to connect to player with error: %@", error.localizedDescription);
    _matchStarted = NO;
    [_delegate mathcEnded];
}



- (void)match:(GKMatch *)match didFailWithError:(NSError *)error {
    if (_match != match) return;
    
    NSLog(@"Match failed with error: %@", error.localizedDescription);
    _matchStarted = NO;
    [_delegate mathcEnded];
}


-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewControllelr:(UIViewController *)viewController delegate:(id<gameCenterFilesDelegate>)delegate{

    if (!_enableGameCenter) return;
    
    _matchStarted = NO;
    self.match = nil;
    _delegate = delegate;
    [viewController dismissViewControllerAnimated:NO completion:nil];
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = minPlayers;
    request.maxPlayers = maxPlayers;
    
    GKMatchmakerViewController *mmvc =
    [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
    mmvc.matchmakerDelegate = self;
    
    [viewController presentViewController:mmvc animated:YES completion:nil];
    

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
        
        if (localPlayer.isAuthenticated) {
            [[NSNotificationCenter defaultCenter]postNotificationName:localPlayerIsAuthenticated object:nil];
            return;
            
        }
        
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
        [[NSNotificationCenter defaultCenter]postNotificationName:localPlayerIsAuthenticated object:nil];
    
    
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
