//
//  Missions.h
//  mgwuEricBraen
//
//  Created by New on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "MainScene.h"
#import "PlayerPlane.h"
#import "MissionManager.h"
#import "Enemy.h"

@interface Missions : CCNode

-(BOOL)stayInPlace:(PlayerPlane *)plane For:(MissionManager *)missCounter Validation:(CCLabelTTF *)goodJob;
-(BOOL)stayAlive:(PlayerPlane *)plane For:(MissionManager *)counter Validation:(CCLabelTTF *)goodJob;
-(BOOL)yourPlane:(PlayerPlane *)plane KillsSoMany:(MissionManager *) counter Validation:(CCLabelTTF *)goodJob;
-(BOOL)yourPlane:(PlayerPlane *)plane checkingLineState:(MissionManager *)enumNum
      Validation:(CCLabelTTF *)goodJob;
-(BOOL)enemies:(Enemy *)right And:(Enemy *)middle Lastly:(Enemy *)left AreAllColour:(MissionManager *)colorChoice Validation:(CCLabelTTF *)goodJob;
-(BOOL)enemies:(Enemy *)right And:(Enemy *)middle Lastly:(Enemy *)left AreAllShape:(MissionManager *)shapeChoice Validation:(CCLabelTTF *)goodJob;
-(BOOL)enemies:(Enemy *)right And:(Enemy *)middle Lastly:(Enemy *)left Specific:(MissionManager *)enemy Validation:(CCLabelTTF *)goodJob;

@end
