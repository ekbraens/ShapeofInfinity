//
//  MissionManager.m
//  mgwuEricBraen
//
//  Created by New on 7/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MissionManager.h"
#import "MainScene.h"
#import "PlayerPlane.h"

@implementation MissionManager {
    NSString * targetColour;
    NSString * fourthMissionString;
    NSString * targetShape;
    NSString * fifthMissionString;
    NSString * sixthMissionString;
}

-(int)missionSelecter:(MainScene *)gameOver
{
    // if there is no mission in progress, select a random mission
    if(_missionInProgress == FALSE)
    {
        _missionNumber = arc4random() % 7;
        
        switch (_missionNumber) {
            case 0:
                [MGWU logEvent:@"mission 0" withParams:nil];
                break;
            case 1:
                [MGWU logEvent:@"mission 1" withParams:nil];
                break;
            case 2:
                [MGWU logEvent:@"mission 2" withParams:nil];
                break;
            case 3:
                [MGWU logEvent:@"mission 3" withParams:nil];
                break;
            case 4:
                _fourthMissionColour = [self randomColourForKilling];
                targetColour = [self numberToColour:_fourthMissionColour];
                fourthMissionString = [NSString stringWithFormat:@"Get all enemies to be color %@.", targetColour];
                [MGWU logEvent:@"mission 4" withParams:nil];
                break;
            case 5:
                _fifthMissionShape = [self randomShapeForKilling];
                targetShape = [self numberToShape:_fifthMissionShape];
                fifthMissionString = [NSString stringWithFormat:@"Get all enemies to be %@s.", targetShape];
                [MGWU logEvent:@"mission 5" withParams:nil];
                break;
            case 6:
                _fourthMissionColour = [self randomColourForKilling];
                _fifthMissionShape = [self randomShapeForKilling];
                targetColour = [self numberToColour:_fourthMissionColour];
                targetShape = [self numberToShape:_fifthMissionShape];
                sixthMissionString = [NSString stringWithFormat:@"Find one %@ %@", targetColour, targetShape];
                [MGWU logEvent:@"mission 6" withParams:nil];
                break;
            default:
                break;
        }
        _missionInProgress = TRUE;
        gameOver.seeNewMission.string = @"New Mission!";
    }
    
    // this is the method to give the mainScene (gameover screen) the string for what the mission objective is
    [self tellMainScene:gameOver];
    return _missionNumber;
}

-(void)tellMainScene:(MainScene *)whatsUp
{
    switch (_missionNumber)
    {
        case 0:
            whatsUp.firstMission.string = @"Do not move for 15 seconds.";
            _firstMissionsSeconds = 0;
            break;
        case 1:
            whatsUp.firstMission.string = @"Stay alive for 60 seconds.";
            _firstMissionsSeconds = 0;
            break;
        case 2:
            whatsUp.firstMission.string = @"Kill 30 aliens in a row.";
            _secondMissionKillCount = 0;
            break;
        case 3:
            whatsUp.firstMission.string = @"Move side to side 8 times";
            _sideToSideCounter = 0;
            _thirdMission = eitherLine;
            break;
        case 4:
            whatsUp.firstMission.string = fourthMissionString;
            break;
        case 5:
            whatsUp.firstMission.string = fifthMissionString;
            break;
        case 6:
            whatsUp.firstMission.string = sixthMissionString;
            break;
        default:
            break;
    }
}

// rest of these methods are randomizers for certain variables of the ships, used for the missions
-(int)randomColourForKilling
{
    int colorChoice = arc4random() % 6;
    
    return colorChoice;
}

-(int)randomShapeForKilling
{
    int shapeChoice = arc4random() % 11;
    
    switch (shapeChoice)
    {
        case 0:
            shapeChoice = 0;
            break;
        case 1:
            shapeChoice = 0;
            break;
        case 2:
            shapeChoice = 1;
            break;
        case 3:
            shapeChoice = 1;
            break;
        case 4:
            shapeChoice = 2;
            break;
        case 5:
            shapeChoice = 2;
            break;
        case 6:
            shapeChoice = 3;
            break;
        case 7:
            shapeChoice = 3;
            break;
        case 8:
            shapeChoice = 4;
            break;
        case 9:
            shapeChoice = 4;
            break;
        case 10:
            shapeChoice = 5;
            break;
        case 11:
            shapeChoice = 5;
            break;
        default:
            break;
    }
    
    return shapeChoice;
}

-(NSString *)numberToColour:(int)theNum
{
    NSString * string;
    
    switch (theNum)
    {
        case 0:
            string = @"red";
            break;
        case 1:
            string = @"orange";
            break;
        case 2:
            string = @"yellow";
            break;
        case 3:
            string = @"green";
             break;
        case 4:
            string = @"blue";
            break;
        case 5:
            string = @"pink";
            break;
        default:
            break;
    }
    return string;
}

-(NSString *)numberToShape:(int)theNum
{
    NSString * string;
    
    switch (theNum)
    {
        case 0:
            string = @"Octahedron Edge";
            break;
        case 1:
            string = @"Cube Face";
            break;
        case 2:
            string = @"Cuboctahedron Edge";
            break;
        case 3:
            string = @"Tetrahedron Edge";
            break;
        case 4:
            string = @"Gyrofigastigium Face";
            break;
        case 5:
            string = @"Tetrahedron Face";
            break;
        default:
            break;
    }
    
    return string;
}

@end
