//
//  PlayerPlane.h
//  mgwuEricBraen
//
//  Created by New on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "PlayerBullet.h"

@interface PlayerPlane : CCNode

@property (nonatomic, strong) PlayerBullet * bullet;

@end
