//
//  GameCenterFiles.h
//  mgwuEricBraen
//
//  Created by New on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenterFiles : NSObject

- (void) authenticateLocalPlayer;
+(BOOL) isGameCenterAvailible;
- (void) reportScore: (int64_t) score forLeaderboardID: (NSString*) category;


@end
