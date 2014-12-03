//
//  TetrahedronFaceL.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TetrahedronFaceL.h"

@implementation TetrahedronFaceL

-(void)shapeMovement
{
    CCActionMoveBy * downLeft = [CCActionMoveBy actionWithDuration:1.34 position:ccp(-25, -50)];
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:1.34 position:ccp(50, 0)];
    CCActionMoveBy * upLeft = [CCActionMoveBy actionWithDuration:1.34 position:ccp(-25, 50)];
    //CCActionMoveBy * downLet = [CCActionMoveBy actionWithDuration:0.67 position:ccp(-25, -25)];
    //CCActionMoveBy * upRight = [CCActionMoveBy actionWithDuration:0.67 position:ccp(25, 25)];
    //CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:0.67 position:ccp(0, 25)];
    
    CCActionSequence * gyrobifastigiumStrafe = [CCActionSequence actions:downLeft, moveRight, upLeft, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:gyrobifastigiumStrafe]];
}


@end
