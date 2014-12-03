//
//  GameCenterFiles.m
//  mgwuEricBraen
//
//  Created by New on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameCenterFiles.h"

@implementation GameCenterFiles

- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            NSLog(@"Player authenticated");
        }
        else{
            NSLog(@"Player not authenticated");
        }
    }];
}

+(BOOL) isGameCenterAvailible
{
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    NSString * requiredSysemVersion = @"4.1";
    NSString * currentVersion = [[UIDevice currentDevice] systemVersion];
    BOOL isVersionSupported = ([currentVersion compare:requiredSysemVersion options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && isVersionSupported);
}

//int is the score in mainscene Nsstring is "soiLeaderBoard"
- (void) reportScore: (int64_t) score forLeaderboardID: (NSString*) category
{
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:category];
    scoreReporter.value = score;
    scoreReporter.context = 0;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        NSLog(@"Score did not report, gameCenterFiles.m");
    }];
}

@end
