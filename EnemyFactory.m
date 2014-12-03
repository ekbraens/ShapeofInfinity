//
//  EnemyFactory.m
//  mgwuEricBraen
//
//  Created by New on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EnemyFactory.h"

@implementation EnemyFactory

// to create a new enemy!
+(Enemy *)createRandomEnemyFrom:(NSArray *)arrayOfEnemies
{
    // check the length of the array of useable enemy names
    NSUInteger numOfEnemiesInArray = [arrayOfEnemies count];
    // get a random number from that array
    int randomNumberChosen = arc4random() % numOfEnemiesInArray;
    // using the random string chosen, load that ccb file, using the string
    NSString * fileToBeLoaded = [arrayOfEnemies objectAtIndex:randomNumberChosen];
    Enemy * newlyGeneratedEnemy = (Enemy *)[CCBReader load:fileToBeLoaded];
    // now set the enemy's properties with random choices
    newlyGeneratedEnemy.shape = randomNumberChosen;
    newlyGeneratedEnemy.colour = [newlyGeneratedEnemy colourChooser:newlyGeneratedEnemy];
    newlyGeneratedEnemy.exists = 1;
    
    // this is for a few missions
    // there are duplicate shapes in the ccb files, but they have different movements on-screen
    switch (newlyGeneratedEnemy.shape)
    {
        case 0:
            newlyGeneratedEnemy.shape = 0;
            break;
        case 1:
            newlyGeneratedEnemy.shape = 0;
            break;
        case 2:
            newlyGeneratedEnemy.shape = 1;
            break;
        case 3:
            newlyGeneratedEnemy.shape = 1;
            break;
        case 4:
            newlyGeneratedEnemy.shape = 2;
            break;
        case 5:
            newlyGeneratedEnemy.shape = 2;
            break;
        case 6:
            newlyGeneratedEnemy.shape = 3;
            break;
        case 7:
            newlyGeneratedEnemy.shape = 3;
            break;
        case 8:
            newlyGeneratedEnemy.shape = 4;
            break;
        case 9:
            newlyGeneratedEnemy.shape = 4;
            break;
        case 10:
            newlyGeneratedEnemy.shape = 5;
            break;
        case 11:
            newlyGeneratedEnemy.shape = 5;
            break;
        default:
            break;
    }
    
    return newlyGeneratedEnemy;
}

@end
