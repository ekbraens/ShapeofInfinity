//
//  Enemy.m
//  mgwuEricBraen
//
//  Created by New on 7/7/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Enemy.h"
#import "EnemyBullet.h"

@implementation Enemy

// put a nsarray of strings, names of all the subclassed enemy-types, to load CCB files from

-(void)shapeMovement
{
    
}

-(void)bulletPattern
{
    
}

// for each enemy created, it is given a specific color by using this method
-(int)colourChooser:(Enemy *)madeEnemy
{
    int colour = arc4random() % 6;
    madeEnemy.cascadeColorEnabled = YES;
    switch (colour)
    {
        case 0:
            NSLog(@"Colour is Red");
            [madeEnemy setColor:[CCColor colorWithRed:(255.f/255.f) green:(50.f/255.f) blue:(0)]];
            break;
        case 1:
            NSLog(@"Colour is Orange");
            [madeEnemy setColor:[CCColor colorWithRed:(255.f/255.f) green:(118.f/225.f) blue:0]];
            break;
        case 2:
            NSLog(@"Colour is Yellow");
            [madeEnemy setColor:[CCColor colorWithRed:1 green:1 blue:0]];
            break;
        case 3:
            NSLog(@"Colour is Green");
            [madeEnemy setColor:[CCColor colorWithRed:0 green:(191.f/255.f) blue:0]];
            break;
        case 4:
            NSLog(@"Colour is Blue");
            [madeEnemy setColor:[CCColor colorWithRed:0 green:(90.f/255.f) blue:1]];
            break;
        case 5:
            NSLog(@"Colour is Pink");
            [madeEnemy setColor:[CCColor colorWithRed:1 green:(88.f/255.f) blue:(210.f/255.f)]];
            break;
        default:
            NSLog(@"colourChooser default statement");
            break;
    }
    return colour;
}

// logic to make those enemies flash and look real good
-(void)setNeonEffect
{
    CCActionFadeTo * fadeOut = [CCActionFadeTo actionWithDuration:.5 opacity:.6f];
    CCActionFadeIn * fadeIn = [CCActionFadeIn actionWithDuration:.3];
    
    CCActionSequence * neonPulse = [CCActionSequence actions:fadeOut, fadeIn, nil];
    
    // run the action as long as they exist, forever, and ever and ever
    [self runAction:[CCActionRepeatForever actionWithAction:neonPulse]];
}

@end
