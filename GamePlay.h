//
//  GamePlay.h
//  mgwuEricBraen
//
//  Created by New on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNode.h"
#import "Enemy.h"
#import "EnemyBullet.h"

@interface GamePlay : CCNode

@property (nonatomic, strong) Enemy * leftEnemy;
@property (nonatomic, strong) Enemy * middleEnemy;
@property (nonatomic, strong) Enemy * rightEnemy;
@property (nonatomic, strong) NSArray * enemyList;
@property (nonatomic, strong) CCLabelTTF * tutorial;
@property (nonatomic, strong) CCNode * shieldUp;

@property (nonatomic, assign) CGSize viewSiz;
@property (nonatomic, assign) CGPoint leftFirePoint;
@property (nonatomic, assign) CGPoint middleFirePoint;
@property (nonatomic, assign) CGPoint rightFirePoint;
@property (nonatomic, assign) CGPoint leftSpawnPoint;
@property (nonatomic, assign) CGPoint middleSpawnPoint;
@property (nonatomic, assign) CGPoint rightSpawnPoint;

@property (nonatomic, assign) BOOL shieldBool;
@property (nonatomic, assign) int shieldTreshold;
@property (nonatomic, assign) int shieldCounter;

@property (nonatomic, assign) CGPoint tutorialOnePoint;
@property (nonatomic, assign) CGPoint tutorialTwoPoint;
@property (nonatomic, assign) CGPoint tutorialThreePoint;
@property (nonatomic, assign) CGPoint tutorialFourPoint;


-(void)moveTo:(CGPoint)destination;

@end