//
//  SelectMation.m
//  mgwuEricBraen
//
//  Created by New on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SelectMation.h"

@implementation SelectMation

-(void)touchAnimation:(CGPoint)touchLocation
{
    SelectMation * selectMationer = (SelectMation *)[CCBReader load:@"SelectMation"];
    selectMationer.position = touchLocation;
    [self addChild:selectMationer];
}
@end
