//
//  gameCenterFiles.h
//  gameCenter
//
//  Created by Anton Orzes on 07.07.2014..
//  Copyright (c) 2014. Anton Orzes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>





@interface gameCenterFiles : NSObject {

    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    

}


@property (assign, readonly) BOOL gameCenterAvailable;
+ (gameCenterFiles *)sharedInstance;

-(void)authenticateLocalUser;


@end
