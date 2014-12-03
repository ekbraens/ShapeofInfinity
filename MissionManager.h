//
//  MissionManager.h
//  mgwuEricBraen
//
//  Created by New on 7/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "MainScene.h"
#import "PlayerPlane.h"

typedef enum {
    eitherLine,
    leftLine,
    rightLine
}missionThree;

@interface MissionManager : CCNode

@property (nonatomic, assign) BOOL missionInProgress;
@property (nonatomic, assign) int missionNumber;
@property (nonatomic, assign) int threeShapesA;
@property (nonatomic, assign) int threeShapesB;
@property (nonatomic, assign) int enemyColourA;
@property (nonatomic, assign) int colorAndShapeA;
@property (nonatomic, assign) int colorAndShapeB;
@property (nonatomic, assign) int zeroMissionSeconds;
@property (nonatomic, assign) int firstMissionsSeconds;
@property (nonatomic, assign) int secondMissionKillCount;
@property (nonatomic, assign) missionThree thirdMission;
@property (nonatomic, assign) int sideToSideCounter;
@property (nonatomic, assign) int fourthMissionColour;
@property (nonatomic, assign) int fifthMissionShape;

-(int)missionSelecter:(MainScene *)gameOver;

@end
