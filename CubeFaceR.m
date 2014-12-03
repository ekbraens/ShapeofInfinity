//
//  CubeFaceR.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CubeFaceR.h"

@implementation CubeFaceR

// follow square outline to the right
-(void)shapeMovement
{
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:1 position:ccp(0, -50)];
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:0.5 position:ccp(25, 0)];
    CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:1 position:ccp(0, 50)];
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-25, 0)];
    
    CCActionSequence * cubeFaceStrafe = [CCActionSequence actions:moveRight, moveUp, moveLeft, moveLeft, moveDown, moveRight, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:cubeFaceStrafe]];
}


@end
