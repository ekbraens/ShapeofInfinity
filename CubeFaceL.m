//
//  CubeFaceL.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CubeFaceL.h"

@implementation CubeFaceL

-(void)shapeMovement
{
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:0.67 position:ccp(0, -25)];
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:0.67 position:ccp(25, 0)];
    CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:0.67 position:ccp(0, 25)];
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:0.67 position:ccp(-25, 0)];
    
    CCActionSequence * cubeFaceStrafe = [CCActionSequence actions:moveDown, moveLeft, moveUp, moveUp, moveRight, moveDown, moveDown, moveRight, moveUp, moveUp, moveLeft, moveDown, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:cubeFaceStrafe]];
}


@end
