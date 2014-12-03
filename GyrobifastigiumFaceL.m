//
//  GyrobifastigiumFaceL.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GyrobifastigiumFaceL.h"

@implementation GyrobifastigiumFaceL

-(void)shapeMovement
{
    CCActionMoveBy * downLeft = [CCActionMoveBy actionWithDuration:0.8 position:ccp(-25, -20)];
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:0.8 position:ccp(0, -30)];
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:0.8 position:ccp(50, 0)];
    CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:0.8 position:ccp(0, 30)];
    CCActionMoveBy * upLeft = [CCActionMoveBy actionWithDuration:0.8 position:ccp(-25, 20)];
    
    CCActionSequence * gyrobifastigiumStrafe = [CCActionSequence actions:downLeft, moveDown, moveRight, moveUp, upLeft, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:gyrobifastigiumStrafe]];
}

@end
