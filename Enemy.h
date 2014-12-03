//
//  Enemy.h
//  mgwuEricBraen
//
//  Created by New on 7/7/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "EnemyBullet.h"

@interface Enemy : CCNode

//@property (nonatomic, strong) EnemyBullet * bullet;
@property (nonatomic, assign) int exists;
@property (nonatomic, assign) int colour;
@property (nonatomic, assign) int shape;
//@property (nonatomic, assign) NSMutableArray * bulletPatternArray;

-(void)shapeMovement;
-(void)bulletPattern;
-(int)colourChooser:(Enemy *)madeEnemy;
-(void)setNeonEffect;

@end
