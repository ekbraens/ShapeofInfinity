//
//  GyrobifastigiumFaceR.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GyrobifastigiumFaceR.h"

@implementation GyrobifastigiumFaceR

-(void)shapeMovement
{
    CCActionMoveBy * downRight = [CCActionMoveBy actionWithDuration:0.8 position:ccp(25, -20)];
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:0.8 position:ccp(0, -30)];
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:0.8 position:ccp(-50, 0)];
    CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:0.8 position:ccp(0, 30)];
    CCActionMoveBy * upRight = [CCActionMoveBy actionWithDuration:0.8 position:ccp(25, 20)];
    
    CCActionSequence * gyrobifastigiumStrafe = [CCActionSequence actions:downRight, moveDown, moveLeft, moveUp, upRight, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:gyrobifastigiumStrafe]];
}


@end
