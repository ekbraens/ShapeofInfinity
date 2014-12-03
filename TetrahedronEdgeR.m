//
//  TetrahedronEdgeR.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TetrahedronEdgeR.h"

@implementation TetrahedronEdgeR

-(void)shapeMovement
{
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:1 position:ccp(0, -50)];
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:1 position:ccp(-50, 0)];
    CCActionMoveBy * topRight = [CCActionMoveBy actionWithDuration:0.5 position:ccp(25, 25)];
    CCActionMoveBy * topLeft = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-25, 25)];
    // CCActionMoveBy * bottomLeft = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-25, -25)];
    CCActionMoveBy * bottomRight = [CCActionMoveBy actionWithDuration:0.5 position:ccp(25, -25)];
    
    CCActionSequence * tetrahedronEdgeStrafe = [CCActionSequence actions:topRight, moveDown, topLeft, topLeft, moveDown, topRight, topRight, moveLeft, bottomRight, bottomRight, moveLeft, topRight, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:tetrahedronEdgeStrafe]];
}

@end
