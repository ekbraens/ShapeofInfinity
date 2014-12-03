//
//  Missions.m
//  mgwuEricBraen
//
//  Created by New on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Missions.h"
#import "PlayerPlane.h"
#import "Enemy.h"
#import "MissionManager.h"
#import "MainScene.h"

@implementation Missions

-(BOOL)stayInPlace:(PlayerPlane *)plane For:(MissionManager *)counter Validation:(CCLabelTTF *)goodJob
{
    // stay in place for 5 x enemyTurn (which is 3), so 15 seconds
    int timeGoal = 5;
    
    // when the counter from gameplay is exactly 5, flash the mission complete string
    if (counter.zeroMissionSeconds == timeGoal)
    {
        goodJob.string = @"Superior Tactics!";
        return FALSE;
    }
    else
    {
         return TRUE;
    }
}
-(BOOL)stayAlive:(PlayerPlane *)plane For:(MissionManager *)counter Validation:(CCLabelTTF *)goodJob
{
    // essentailly the same logic as above
    int timeGoal = 20;
    
    if (counter.firstMissionsSeconds == timeGoal)
    {
        goodJob.string = @"Survival is Key!";
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

-(BOOL)yourPlane:(PlayerPlane *)plane KillsSoMany:(MissionManager *) counter Validation:(CCLabelTTF *)goodJob
{
    int killGoal = 30;
    
    if (counter.secondMissionKillCount == killGoal)
    {
        goodJob.string = @"Running Riot!";
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

-(BOOL)yourPlane:(PlayerPlane *)plane checkingLineState:(MissionManager *)enumNum
      Validation:(CCLabelTTF *)goodJob
{
    int moveGoal = 8;
    
    // in the beginning, _thePlayerPlane can touch either side of the screen for a ++counter
    switch (enumNum.thirdMission) {
        case eitherLine:
            if (plane.position.x < 25)
            {
                enumNum.thirdMission = rightLine;
                ++enumNum.sideToSideCounter;
            }
            if (plane.position.x > 295)
            {
                enumNum.thirdMission = leftLine;
                ++enumNum.sideToSideCounter;
            }
            break;
    // then set the next line the player must cross to the opposite side of the screen
        case leftLine:
            if (plane.position.x < 25)
            {
                enumNum.thirdMission = rightLine;
                ++enumNum.sideToSideCounter;
            }
            break;
        case rightLine:
            if (plane.position.x > 295)
            {
                enumNum.thirdMission = leftLine;
                ++enumNum.sideToSideCounter;
            }
            break;
        default:
            break;
    }
    
    if (enumNum.sideToSideCounter == moveGoal)
    {
        goodJob.string = @"Dodging Ace!";
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

-(BOOL)enemies:(Enemy *)right And:(Enemy *)middle Lastly:(Enemy *)left AreAllColour:(MissionManager *)colorChoice Validation:(CCLabelTTF *)goodJob
{
    // if all the enemies are the same color, you win the mission
    if ((left.colour == colorChoice.fourthMissionColour) && (middle.colour == colorChoice.fourthMissionColour) && (right.colour == colorChoice.fourthMissionColour))
    {
        goodJob.string = @"Precise Destruction!";
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
-(BOOL)enemies:(Enemy *)right And:(Enemy *)middle Lastly:(Enemy *)left AreAllShape:(MissionManager *)shapeChoice Validation:(CCLabelTTF *)goodJob
{
    // essentially the same as above mission, but with shapes instead of colors
    if ( (left.shape == shapeChoice.fifthMissionShape) && (middle.shape == shapeChoice.fifthMissionShape) && (right.shape == shapeChoice.fifthMissionShape) )
    {
        goodJob.string = @"Geometry Master!";
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

-(BOOL)enemies:(Enemy *)right And:(Enemy *)middle Lastly:(Enemy *)left Specific:(MissionManager *)enemy Validation:(CCLabelTTF *)goodJob
{
    // if any enemy on screen is both the specifc shape AND specific color, you win!
    if ( ((left.colour == enemy.fourthMissionColour) && (left.shape == enemy.fifthMissionShape)) ||
        ((middle.colour == enemy.fourthMissionColour) && (middle.shape == enemy.fifthMissionShape)) ||
        ((right.colour == enemy.fourthMissionColour) && (right.shape == enemy.fifthMissionShape)) )
    {
        goodJob.string = @"Big Game Hunter!";
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

@end
