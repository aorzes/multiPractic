//
//  gameCenterFiles.h
//  gameCenter
//
//  Created by Anton Orzes on 07.07.2014..
//  Copyright (c) 2014. Anton Orzes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

BOOL _matchStarted;

extern NSString *const localPlayerIsAuthenticated;

@protocol gameCenterFilesDelegate
-(void)matchStarted;
-(void)mathcEnded;
-(void)match:(GKMatch *)match didReceiveData:( NSData *)data fromRemotePlayer:(GKPlayer *)player;


@end

@interface gameCenterFiles : NSObject<GKGameCenterControllerDelegate, GKGameCenterControllerDelegate, GKMatchmakerViewControllerDelegate, GKMatchDelegate> {

    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    

}

+(instancetype)sharedGameKitHelper;
@property (strong, nonatomic) GKMatch *match;
@property (nonatomic, assign) id <gameCenterFilesDelegate> delegate;

-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewControllelr:(UIViewController *)viewController delegate:(id<gameCenterFilesDelegate>)delegate;

@property (assign, readonly) BOOL gameCenterAvailable;
+ (gameCenterFiles *)sharedInstance;

-(void)authenticateLocalUser;


@end
