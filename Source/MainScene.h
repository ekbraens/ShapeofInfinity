//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface MainScene : CCScene

@property (nonatomic, assign) int alienArmada;
@property (nonatomic, strong) CCLabelTTF * firstMission;
@property (nonatomic, strong) CCLabelTTF * seeNewMission;
//@property (nonatomic, assign) BOOL isMuteOn;
@property (nonatomic, strong) NSUserDefaults * defaultIsMuteOn;

@end
