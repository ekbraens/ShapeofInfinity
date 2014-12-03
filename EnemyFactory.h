//
//  EnemyFactory.h
//  mgwuEricBraen
//
//  Created by New on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Enemy.h"

@interface EnemyFactory : CCNode

+(Enemy *)createRandomEnemyFrom:(NSArray *)arrayOfEnemies;

@end
