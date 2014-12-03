//
//  GamePlay.m
//  mgwuEricBraen
//
//  Created by New on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.

#import "GamePlay.h"
#import "MainScene.h"
#import "PlayerPlane.h"
#import "PlayerBullet.h"
#import "EnemyFactory.h"
#import "StartButton.h"
#import "EnemyBullet.h"
#import "SelectMation.h"
#import "Missions.h"
#import "MissionManager.h"
#import "GameCenterFiles.h"
#import "NSUserDefaults+Encryption.h"

// not kool, should fix this
BOOL _startScreenHappened;
static MissionManager * missionCenter = nil;
int swipeTutorial;

@implementation GamePlay {
    PlayerPlane * _thePlayerPlane;
    float _speed;
    float _speedEnemyBullet;
    float _rateEnemyBullet;
    CCActionMoveTo * _moveAction;
    CGPoint touchLocation;
    int currentEnemyTouched;
    Enemy * enemyTouched;
    Enemy * startButton;
    NSMutableArray * arrayOfBullets;
    BOOL hitByBullet;
    int missCounter;
    int shotsFired;
    int enemiesKilled;
    int missionOneCounter;
    MainScene * mainScene;
    Missions * newMission;
    //CCLabelTTF * _tapRight;
    //CCLabelTTF * _tapLeft;
    CCNode * _SoILogo;
    
    CCNode * anomalyOne;
    CCNode * anomalyTwo;
    CCNode * anomalyThree;
    CCNode * anomalyFour;
    int anomalyInvestigated;
    NSString * anomalyText;
}

- (void)update:(CCTime)delta
{
    if (_startScreenHappened == FALSE)
    {
        if (CGRectIntersectsRect(_thePlayerPlane.boundingBox, anomalyOne.boundingBox))
        {
            [anomalyOne.children[0] stopSystem];
            anomalyOne = nil;
            --anomalyInvestigated;
            _tutorial.string = [NSString stringWithFormat:@"%d glowing orbs to investigate", anomalyInvestigated];
        }
        else if (CGRectIntersectsRect(_thePlayerPlane.boundingBox, anomalyTwo.boundingBox))
        {
            [anomalyTwo.children[0] stopSystem];
            anomalyTwo = nil;
            --anomalyInvestigated;
            _tutorial.string = [NSString stringWithFormat:@"%d glowing orbs to investigate", anomalyInvestigated];

        }
        else if (CGRectIntersectsRect(_thePlayerPlane.boundingBox, anomalyThree.boundingBox))
        {
            [anomalyThree.children[0] stopSystem];
            anomalyThree = nil;
            --anomalyInvestigated;
            _tutorial.string = [NSString stringWithFormat:@"%d glowing orbs to investigate", anomalyInvestigated];

        }
        else if (CGRectIntersectsRect(_thePlayerPlane.boundingBox, anomalyFour.boundingBox))
        {
            [anomalyFour.children[0] stopSystem];
            anomalyFour = nil;
            --anomalyInvestigated;
            _tutorial.string = [NSString stringWithFormat:@"%d glowing orbs to investigate", anomalyInvestigated];
        }
        else if (anomalyInvestigated == 0)
        {
            _tutorial.string = @"On NO! Aliens!!!";
            startButton.position = _middleFirePoint;
        }
    }
    
    // logic to check if player bullet has struck an enemy
    [self playerBulletIntersetsEnemy];
    
    // logic to check if any enemy bullet has hit the playerPlane
    for (int i = 0; i < [arrayOfBullets count]; ++i)
    {
        if (hitByBullet == NO)
        {
            [self enemyBulletIntersectsPlayer:arrayOfBullets[i]];
            [self removeStrayBullets:arrayOfBullets[i]];
        }
    }
    
    // bullet logic
    float xo = _thePlayerPlane.bullet.position.x;
    float yo = _thePlayerPlane.bullet.position.y;
    float x1 = enemyTouched.position.x;
    float y1 = enemyTouched.position.y;
    float velocity = 200;
    float theta = atan( -(y1 - yo) / -(x1 - xo) );
    if (x1 < xo)
    {
        theta += M_PI;
    }
    CGPoint changePosition = ccpMult(ccp(cos(theta),sin(theta)), (velocity * delta) );
    _thePlayerPlane.bullet.position = ccpAdd(_thePlayerPlane.bullet.position, changePosition);
    
    if (_shieldBool)
    {
        _shieldUp.position = _thePlayerPlane.position;
    }
    
    // This is mission logic, this mission checks where the plane's position is, must be in update method
    if (missionCenter.missionNumber == 3)
    {
        missionCenter.missionInProgress = [newMission yourPlane:_thePlayerPlane checkingLineState:missionCenter
                                                     Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }
    }
}

- (void) didLoadFromCCB
{
    // create the GameCenter, so players can log in and report scores
    if ([GameCenterFiles isGameCenterAvailible])
    {
        GameCenterFiles * gameCenter = [[GameCenterFiles alloc] init];
        [gameCenter authenticateLocalPlayer];
    }
    
    // enables touch for game input
    self.userInteractionEnabled = TRUE;
    
    // make sure this bool is FALSE
    hitByBullet = FALSE;
    // constant speed of plane in -moveTo function
    _speed = 140.0;
    _speedEnemyBullet = 5;
    _rateEnemyBullet = 3;
    missCounter = 0;
    shotsFired = 0;
    missionOneCounter = 0;
    anomalyInvestigated = 4;
    _shieldCounter = 0;
    _shieldTreshold = 5;
    
    // logic for where enemies spawn on screen for all devices
    _viewSiz = [[CCDirector sharedDirector] viewSize];
    _leftFirePoint = ccp(_viewSiz.width*0.25, _viewSiz.height*0.83);
    _middleFirePoint = ccp(_viewSiz.width*0.50, _viewSiz.height*0.83);
    _rightFirePoint = ccp(_viewSiz.width*0.75, _viewSiz.height*0.83);
    _leftSpawnPoint = ccp(_viewSiz.width*0.25, _viewSiz.height*1.1);
    _middleSpawnPoint = ccp(_viewSiz.width*0.50, _viewSiz.height*1.1);
    _rightSpawnPoint = ccp(_viewSiz.width*0.75, _viewSiz.height*1.1);
    
    _tutorialOnePoint = ccp(_viewSiz.width*0.10, _viewSiz.height*0.20);
    _tutorialTwoPoint = ccp(_viewSiz.width*0.05, _viewSiz.height*0.45);
    _tutorialThreePoint = ccp(_viewSiz.width*0.85, _viewSiz.height*0.45);
    _tutorialFourPoint = ccp(_viewSiz.width*0.85, _viewSiz.height*0.20);
    
    // create a main scene for methods to pass their information to
    mainScene = (MainScene*)[CCBReader load:@"MainScene"];
    
    newMission = [[Missions alloc] init];
    
    //create singleton, to keep track of what mission are active and stats for current mission
    if (!missionCenter)
    {
        [[NSUserDefaults standardUserDefaults] setEncryptionKey:@"myencryptionkey!"];
        missionCenter = [[MissionManager alloc] init];
    }
    
    // for all enemy bullets, make sure there is nothing inside with removeAllObjects
    if (!arrayOfBullets)
    {
        arrayOfBullets = [[NSMutableArray alloc] init];
    }
    [arrayOfBullets removeAllObjects];
    
    // list of enemies to be randomly selected
    _enemyList = [NSArray arrayWithObjects:@"OctahedronEdgeR", @"OctahedronEdgeL", @"CubeFaceR", @"CubeFaceL", @"CuboctahedronEdgeR", @"CuboctahedronEdgeL", @"TetrahedronEdgeL", @"TetrahedronEdgeR", @"GyrobifastigiumFaceR", @"GyrobifastigiumFaceL", @"TetrahedronFaceR", @"TetrahedronFaceL", nil];
}

- (void)onEnterTransitionDidFinish
{
    // needed to stop warning
    [super onEnterTransitionDidFinish];
    
    // preload and play gameplay music, its 8-bit 12-tone. proven to be the best music... ever
    [[OALSimpleAudio sharedInstance] preloadBg:@"ericstwelvetone.m4a"];
    [[OALSimpleAudio sharedInstance] playBg:@"ericstwelvetone.m4a" loop:TRUE];
    
    // load the start button, only the first time enemyPopulate is called
    if (_startScreenHappened == FALSE)
    {
        [self startScreenLoader];
    }
    
    // once the startButton is shot, remove tutorial strings and bring on the enemy ships
    if (_startScreenHappened == TRUE)
    {
        [_SoILogo removeFromParent];
        [self enemyPopulate];
       // _tapRight.string = @" ";
       // _tapLeft.string = @" ";
        [missionCenter missionSelecter:mainScene];
    }
    
    _shieldUp = (CCNode *)[CCBReader load:@"ShieldUp"];
    [self addChild:_shieldUp];
    _shieldUp.visible = NO;
    
    // enemy bullets fire every "_rateEnemyBullet" interval, this repeats as long as gameplay exists
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(),
    ^{
        [self schedule:@selector(enemyTurn) interval:_rateEnemyBullet];

    });
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // want to know the location of a touch
    touchLocation = [touch locationInNode:self];
    
    // if touch is inside the start button, start to game up!
    if (CGRectContainsPoint(startButton.boundingBox, touchLocation))
    {
        // cool fade out for tutorial screen
        _SoILogo.cascadeOpacityEnabled = YES;
        [_SoILogo runAction:[CCActionFadeOut actionWithDuration:2]];
        
        // turn off the tutorial text
        //_tapRight.string = @" ";
        // _tapLeft.string = @" ";
        
        // for animation TODO make this a seperate function
        SelectMation * selectMationer = (SelectMation *)[CCBReader load:@"SelectMation"];
        selectMationer.position = touchLocation;
        [self addChild:selectMationer];
        
        currentEnemyTouched = 7;
        
        if (!enemyTouched)
        {
            enemyTouched = startButton;
        }
        
        // so you cant select an enemy when the rocket is in midflight
        if (!_thePlayerPlane.bullet)
        {
            [self playerTurnBulletFires];
        }
    }
    // if touch is inside an enemy, do not move ship
    else if (CGRectContainsPoint(_leftEnemy.boundingBox, touchLocation))
    {
        // keep track of which enemy is touched
        currentEnemyTouched = 1;
        
        // touch logic
        _leftEnemy = [self userTouched:_leftEnemy];
    }
    else if (CGRectContainsPoint(_middleEnemy.boundingBox, touchLocation))
    {
        currentEnemyTouched = 2;
        _middleEnemy = [self userTouched:_middleEnemy];
    }
    else if (CGRectContainsPoint(_rightEnemy.boundingBox, touchLocation))
    {
        currentEnemyTouched = 3;
        _rightEnemy = [self userTouched:_rightEnemy];
    }
    else
    {
        // make sure _thePlayerPlane can not fly behind the enemies
        if (touchLocation.y < 350)
        {
            // move playerPlane to the location of the touch
            [self moveTo:touchLocation];
            
            // reset zeroMission, have moved
            missionCenter.zeroMissionSeconds = 0;
        }
    }
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // swipe tutorial shoudlnt happen during the start screen
    // do not want it to interfere with tutorial
    if (_startScreenHappened == TRUE)
    {
        // should only happen a couple times, theyll get it eventually
        ++swipeTutorial;
        if (swipeTutorial < 3)
        {
            // text to display
            _tutorial.string = @"NO SWIPING! tap to move!";
        }
    }
}

# pragma mark - Player Movement
// courtesy of Ramone, keeps movement constant
- (void)moveTo:(CGPoint)destination
{
    // stop _thePlayerPlane's movement once new touch is made on screen
    [_thePlayerPlane stopAllActions];
    
    // this is magic
    float distance = hypotf(_thePlayerPlane.position.x - destination.x, _thePlayerPlane.position.y - destination.y);
    
    // use the magic
    _moveAction = [CCActionMoveTo actionWithDuration:distance/_speed position:destination];
    
    // run my created _moveAction on _thePlayerPlane to new location
    [_thePlayerPlane runAction:_moveAction];
}

# pragma mark - Reset Dead Enemy
-(void)enemyPopulate
{
    if (_startScreenHappened == FALSE)
    {
        return;
    }
    // if there isnt an enemy in point x 80 (left most enemy)
    // create the enemy offscreen and move him down screen into position
    if (_leftEnemy.exists == 0)
    {
        // create a new Enemy and set its position/movement
        _leftEnemy = [self singlePopulate:_leftEnemy comesIn:_leftSpawnPoint andMovesTo:_leftFirePoint];
    }
    // do the same as above for middle and right enemies
    if (_middleEnemy.exists == 0)
    {
        _middleEnemy = [self singlePopulate:_middleEnemy comesIn:_middleSpawnPoint andMovesTo:_middleFirePoint];
    }
    if (_rightEnemy.exists == 0)
    {
        _rightEnemy = [self singlePopulate:_rightEnemy comesIn:_rightSpawnPoint andMovesTo:_rightFirePoint];
    }
    
    // When certain mission are activated, run individual logic. these missions have to do with enemy properties
    if (missionCenter.missionNumber == 4)
    {
        missionCenter.missionInProgress = [newMission enemies:_rightEnemy And:_middleEnemy Lastly:_leftEnemy AreAllColour:missionCenter Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }
    }
    if (missionCenter.missionNumber == 5)
    {
        missionCenter.missionInProgress = [newMission enemies:_rightEnemy And:_middleEnemy Lastly:_leftEnemy AreAllShape:missionCenter Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }
    }
    if (missionCenter.missionNumber == 6)
    {
        missionCenter.missionInProgress = [newMission enemies:_rightEnemy And:_middleEnemy Lastly:_rightEnemy Specific:missionCenter Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }
    }
}

# pragma mark - Bullet Firing Logic
-(Enemy *)userTouched:(Enemy *)thatEnemy
{
    // the animation that runs when you touch an enemy
    SelectMation * selectMationer = (SelectMation *)[CCBReader load:@"SelectMation"];
    selectMationer.position = touchLocation;
    [self addChild:selectMationer];
    
    // if _thePlayerPlane's bullet is not instantiated, you can select a certain enemy
    if (!_thePlayerPlane.bullet)
    {
        enemyTouched = thatEnemy;
    }
    
    // if _thePlayerPlane's bullet is not instantiated, a new one can be fired
    if (!_thePlayerPlane.bullet)
    {
        [self playerTurnBulletFires];
    }
    
    return thatEnemy;
}

// create _thePlayerPlane bullet
- (void)playerShootBulletAt:(int)atEnemy
{
    // for normal coding, but becuse of spritebuilder
    //CCSprite *projectile = [CCSprite spriteWithImageNamed:@"projectile.png"];
    _thePlayerPlane.bullet = (PlayerBullet *)[CCBReader load:@"PlayerBullet"];
    
    // now add the bullet into the scene
    _thePlayerPlane.bullet.position = _thePlayerPlane.position;
    [self addChild:_thePlayerPlane.bullet];
}

- (void)playerTurnBulletFires
{
    missCounter = 0;
    _tutorial.string = @" ";
    [self playerShootBulletAt:currentEnemyTouched];
}

- (void)playerStruckBy:(CCNode *)enemyBullet
{
    // once the bullet intersects the enemy, remove each from gameplay
    [enemyBullet removeFromParent];
    [_thePlayerPlane removeFromParent];
}

- (void)EnemyShootBullet:(Enemy *)thatEnemy
{
    // depending on which color a certain enemy is, fire a distinct pattern.
    switch (thatEnemy.colour)
    {
        case 0:
            [self redPattern:thatEnemy];
            break;
        case 1:
            [self orangePattern:thatEnemy];
            break;
        case 2:
            [self yellowPattern:thatEnemy];
            break;
        case 3:
            [self greenPattern:thatEnemy];
            break;
        case 4:
            [self bluePattern:thatEnemy];
            break;
        case 5:
            [self pinkPattern:thatEnemy];
            break;
        default:
            NSLog(@"EnemyShootBullet default message");
            break;
    }
}

- (Enemy *)EnemyStruckByPlayerBullet:(Enemy *)theEnemy
{
    // clean up the collision between player bullet and enemy, happens alot
    [theEnemy removeFromParent];
    [_thePlayerPlane.bullet removeFromParent];
    _thePlayerPlane.bullet = nil;
    theEnemy.exists = 0;
    currentEnemyTouched = 0;
    enemyTouched = nil;
    
    // keep track of enemies destroyed
    ++enemiesKilled;
    
    ++_shieldCounter;
    if (_shieldCounter == _shieldTreshold)
    {
        _shieldBool = TRUE;
        
        _shieldUp.visible = YES;
        _shieldUp.position = _thePlayerPlane.position;
        
        _shieldTreshold += 5;
    }
    
    // logic for secondMission, mission is dependant on enemies killed, seperated from normal enemies killed
    ++missionCenter.secondMissionKillCount;
    if (missionCenter.missionNumber == 2)
    {
        missionCenter.missionInProgress = [newMission yourPlane:_thePlayerPlane KillsSoMany:missionCenter Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }
    }
    
    return theEnemy;
}

# pragma mark - Turn Logic
-(void)playerTurn
{
    if ( (currentEnemyTouched == 1) || (currentEnemyTouched == 2) || (currentEnemyTouched == 3) || (currentEnemyTouched == 7))
    {
        missCounter = 0;
        _tutorial.string = @" ";
        [self playerTurnBulletFires];
    }

}

-(void)enemyTurn
{
    ++missCounter;
    ++shotsFired;
    
    // mission logic, these missions are dependant on incrementing how long the player has been alive
    // this is kept track of by how many bullets the enemy cluster has fired
    ++missionCenter.firstMissionsSeconds;
    ++missionCenter.zeroMissionSeconds;
    if (missionCenter.missionNumber == 0)
    {
        // mission for staying in place
        missionCenter.missionInProgress = [newMission stayInPlace:_thePlayerPlane
                                                              For:missionCenter Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }

    }
    if (missionCenter.missionNumber == 1)
    {
        //mission for staying alive
        missionCenter.missionInProgress = [newMission stayAlive:_thePlayerPlane
                                                            For:missionCenter Validation:_tutorial];
        if (!missionCenter.missionInProgress)
        {
            missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        }

    }
    
    // if the enemy exists when method is called, the enemy will fire it's bullets
    if (_leftEnemy)
    {
        {
            [self EnemyShootBullet:_leftEnemy];
        }
    }
    if (_middleEnemy)
    {
        {
            [self EnemyShootBullet:_middleEnemy];
        }
    }
    if (_rightEnemy)
    {
        {
            [self EnemyShootBullet:_rightEnemy];
        }
    }
    
    // tutorial string, for when the player hasnt fired a bullet in three "turns"
    if (missCounter == 2)
    {
        if (_startScreenHappened == FALSE)
        {
            if (anomalyInvestigated == 4)
            {
                _tutorial.string = @"Tap on glowing orbs to investigate";
            }
        }
        else
        {
            _tutorial.string = @"Tap Alien To Fire";
        }
    }
}

-(Enemy *)singlePopulate:(Enemy *)thatEnemy comesIn:(CGPoint)spawnLoc andMovesTo:(CGPoint)firingLoc
{
    // for normal coding
    // _leftEnemy = [[Enemy alloc] init];
    // but because we are useing spritebuilder, cast and load from ccbreader
    //_leftEnemy = (Enemy *)[CCBReader load:@"Enemy"];
    
    // load in an enemy randomly, using EnemyFactory
    thatEnemy = [EnemyFactory createRandomEnemyFrom:_enemyList];
    // add _left enemy into gameplay and set it's position
    [self addChild:thatEnemy z:1];
    thatEnemy.position = spawnLoc;
    
    // this is the move that beings the shape from offscreen
    CCActionMoveTo * moveIntoScreen = [CCActionMoveTo actionWithDuration:2 position:firingLoc];
    // this is the move that runs the specific shapes stafing movement
    CCActionCallFunc * callsShapeMovement = [CCActionCallFunc actionWithTarget:thatEnemy selector:@selector(shapeMovement)];
    // this is the way to make one action happen, then the second acion, seperately
    CCActionSequence * moveOneThenTwo = [CCActionSequence actionOne:moveIntoScreen two:callsShapeMovement];
    
    thatEnemy.cascadeOpacityEnabled = YES;
    [thatEnemy setNeonEffect];
    
    [thatEnemy runAction:moveOneThenTwo];
    
    return thatEnemy;
}

# pragma mark - Bullet Intersect Logic
-(void)playerBulletIntersetsEnemy
{
    // beginning of the game, for playerBullet to interesct start button
    if ( (_startScreenHappened == FALSE) && CGRectIntersectsRect(_thePlayerPlane.bullet.boundingBox, startButton.boundingBox) )
    {
        startButton = [self EnemyStruckByPlayerBullet:startButton];
        _startScreenHappened = TRUE;
        
        missionCenter.missionInProgress = FALSE;
        missionCenter.missionNumber = [missionCenter missionSelecter:mainScene];
        
        _tutorial.string = @" ";
        [self enemyPopulate];
        startButton = nil;
    }
    
    // if a player bullet strikes an enemy logic
    if ( (_startScreenHappened == TRUE) && CGRectIntersectsRect(_thePlayerPlane.bullet.boundingBox, _leftEnemy.boundingBox) )
    {
        _leftEnemy = [self EnemyStruckByPlayerBullet:_leftEnemy];
        [self enemyPopulate];
    }
    if ( (_startScreenHappened == TRUE) && CGRectIntersectsRect(_thePlayerPlane.bullet.boundingBox, _middleEnemy.boundingBox) )
    {
        _middleEnemy = [self EnemyStruckByPlayerBullet:_middleEnemy];
        [self enemyPopulate];
    }
    if ( (_startScreenHappened == TRUE) && CGRectIntersectsRect(_thePlayerPlane.bullet.boundingBox, _rightEnemy.boundingBox) )
    {
        _rightEnemy = [self EnemyStruckByPlayerBullet:_rightEnemy];
        [self enemyPopulate];
    }
}

-(void)enemyBulletIntersectsPlayer:(EnemyBullet *)withBullet
{
    // to check if an EnemyBullet hits thePlayerPlane, GAME OVER
    if (CGRectIntersectsRect(withBullet.boundingBox, _thePlayerPlane.boundingBox) )
    {
        if (_shieldBool)
        {
            withBullet.position = ccp(-5, -5);
            
            _shieldBool = FALSE;
            _shieldUp.visible = NO;
            _shieldCounter = 0;
        }
        else
        {
            [self playerStruckBy:withBullet];
            hitByBullet = YES;
            [self switchToGameOverScreen];
        }
    }
    else if (CGRectIntersectsRect(withBullet.boundingBox, _thePlayerPlane.boundingBox) )
    {
        if (_shieldBool)
        {
        withBullet.position = ccp(-5, -5);
            
            _shieldBool = FALSE;
            _shieldUp.visible = NO;
            _shieldCounter = 0;
        }
        else
        {
            [self playerStruckBy:withBullet];
            hitByBullet = YES;
            [self switchToGameOverScreen];
        }
    }
    else if (CGRectIntersectsRect(withBullet.boundingBox, _thePlayerPlane.boundingBox) )
    {
        if (_shieldBool)
        {
            withBullet.position = ccp(-5, -5);
            
            _shieldBool = FALSE;
            _shieldUp.visible = NO;
            _shieldCounter = 0;
        }
        else
        {
            [self playerStruckBy:withBullet];
            hitByBullet = YES;
            [self switchToGameOverScreen];
        }
    }
}

-(void)removeStrayBullets:(EnemyBullet *)withBullet
{
    // if bullet is below the scren, take them out of the array and clean them up
    if (withBullet.position.y < 0)
    {
        [arrayOfBullets removeObject:withBullet];
    }
     // if bullet is off to either side of the screen, clean them up
    if ( (withBullet.position.x < 0) || (withBullet.position.x > 350))
    {
        [arrayOfBullets removeObject:withBullet];
    }
}
 
#pragma mark - button logic
-(void)switchToGameOverScreen
{
    // replace scene to GAME OVER scene
    mainScene.alienArmada = 222 - enemiesKilled;
    CCScene *scene = [CCScene node];
    [scene addChild:mainScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

-(void)startScreenLoader
{
    anomalyOne = (CCNode *)[CCBReader load:@"TutorialMation"];
    anomalyOne.position = _tutorialOnePoint;
    anomalyTwo = (CCNode *)[CCBReader load:@"TutorialMation"];
    anomalyTwo.position = _tutorialTwoPoint;
    anomalyThree = (CCNode *)[CCBReader load:@"TutorialMation"];
    anomalyThree.position = _tutorialThreePoint;
    anomalyFour = (CCNode *)[CCBReader load:@"TutorialMation"];
    anomalyFour.position = _tutorialFourPoint;
    [self addChild:anomalyOne];
    [self addChild:anomalyTwo];
    [self addChild:anomalyThree];
    [self addChild:anomalyFour];
    
    startButton = (StartButton *)[CCBReader load:@"StartButton"];
    [self addChild:startButton];
    startButton.position = _middleSpawnPoint;
}


#pragma mark - bullet patterns
//
// ALL the enemy bullet pattern logic, I wish it was not in this class, but...
// some of the dispatch methods i use will not work otherwise
// arguably i should not be using dispatch, but instead an action sequence with delays
// but some other people would argue i shouldnt waste my time and i shipped my game on time; what up
//
-(EnemyBullet *)origin:(Enemy *)enemy FromX:(int)oldX FromY:(int)oldY ToX:(int)newX ToY:(int)newY WithDuration:(int)time
{
    EnemyBullet * bullet = (EnemyBullet *)[CCBReader load:@"EnemyBullet"];
    
    // depending on what color the enemy is, set the pattern and color of the bullets accordingly
    bullet.cascadeColorEnabled = YES;
    switch (enemy.colour)
    {
        case 0:
            [bullet setColor:[CCColor colorWithRed:(255.f/255.f) green:(50.f/255.f) blue:(0)]];
            bullet.colourBullet = 0;
            break;
        case 1:
            [bullet setColor:[CCColor colorWithRed:(255.f/255.f) green:(118.f/225.f) blue:0]];
            bullet.colourBullet = 1;
            break;
        case 2:
            [bullet setColor:[CCColor colorWithRed:1 green:1 blue:0]];
            bullet.colourBullet = 2;
            break;
        case 3:
            [bullet setColor:[CCColor colorWithRed:0 green:(191.f/255.f) blue:0]];
            bullet.colourBullet = 3;
            break;
        case 4:
            [bullet setColor:[CCColor colorWithRed:0 green:(90.f/255.f) blue:1]];
            bullet.colourBullet = 4;
            break;
        case 5:
            [bullet setColor:[CCColor colorWithRed:1 green:(88.f/255.f) blue:(210.f/255.f)]];
            bullet.colourBullet = 5;
            break;
        default:
            NSLog(@"colourChooser default statement");
            break;
    }
    
    // all logic for specific variables you can plug in to make various patterns.
    // tried to make a single method for easy customization
    // i think it turned out alright
    CGPoint firingFrom = CGPointMake(enemy.position.x+oldX, enemy.position.y+oldY);
    bullet.position = firingFrom;
    [self addChild:bullet];
   
    CGPoint firingTo = CGPointMake(enemy.position.x+newX, enemy.position.y+newY);
    CCActionMoveTo * actionMove = [CCActionMoveTo actionWithDuration:time position:firingTo];
    CCActionRemove * actionRemove = [CCActionRemove action];
    
    [bullet runAction:[CCActionSequence actionWithArray:@[actionMove, actionRemove]]];
    [arrayOfBullets addObject:bullet];
    
    return bullet;
}

// this is essentially the same thing as the above method, but called for bullet splitting
// could not use the same origin method because it takes and returns an enemy, not enemyBullet
// maybe i should use id
-(EnemyBullet *)brigin:(EnemyBullet *)frag FromX:(int)oldX FromY:(int)oldY ToX:(int)newX ToY:(int)newY withSpeed:(int)time
{
    EnemyBullet * bullet = (EnemyBullet *)[CCBReader load:@"EnemyBullet"];
    
    bullet.cascadeColorEnabled = YES;
    switch (frag.colourBullet)
    {
        case 0:
            [bullet setColor:[CCColor colorWithRed:(255.f/255.f) green:(50.f/255.f) blue:(0)]];
            break;
        case 1:
            [bullet setColor:[CCColor colorWithRed:(255.f/255.f) green:(118.f/225.f) blue:0]];
            break;
        case 2:
            [bullet setColor:[CCColor colorWithRed:1 green:1 blue:0]];
            break;
        case 3:
            [bullet setColor:[CCColor colorWithRed:0 green:(191.f/255.f) blue:0]];
            break;
        case 4:
            [bullet setColor:[CCColor colorWithRed:0 green:(90.f/255.f) blue:1]];
            break;
        case 5:
            [bullet setColor:[CCColor colorWithRed:1 green:(88.f/255.f) blue:(210.f/255.f)]];
            break;
        default:
            NSLog(@"colourChooser default statement");
            break;
    }
    
    CGPoint firingFrom = CGPointMake(frag.position.x+oldX, frag.position.y+oldY);
    bullet.position = firingFrom;
    
    [self addChild:bullet];
    
    CGPoint firingTo = CGPointMake(frag.position.x+newX, frag.position.y+newY);
    CCActionMoveTo * actionMove = [CCActionMoveTo actionWithDuration:time position:firingTo];
    CCActionRemove * actionRemove = [CCActionRemove action];
    
    [bullet runAction:[CCActionSequence actionWithArray:@[actionMove, actionRemove]]];
    [arrayOfBullets addObject:bullet];
    
    return bullet;
}

-(void)redPattern:(Enemy *)forEnemy
{
    [self origin:forEnemy FromX:-20 FromY:0 ToX:-200 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:0 FromY:0 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:20 FromY:0 ToX:200 ToY:-700 WithDuration:_speedEnemyBullet];
}
-(void)orangePattern:(Enemy *)forEnemy
{
    [self origin:forEnemy FromX:-50 FromY:0 ToX:-50 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:50 FromY:0 ToX:50 ToY:-700 WithDuration:_speedEnemyBullet];
}
-(void)pinkPattern:(Enemy *)forEnemy
{
    [self origin:forEnemy FromX:20 FromY:20 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:20 FromY:-20 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:-20 FromY:20 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:-20 FromY:-20 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    [self origin:forEnemy FromX:0 FromY:0 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
}
-(void)yellowPattern:(Enemy *)forEnemy
{
    [self origin:forEnemy FromX:0 FromY:0
             ToX:(-forEnemy.position.x + _thePlayerPlane.position.x)
             ToY:(-forEnemy.position.y - 15)
    WithDuration:3.5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_speedEnemyBullet*.2) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self origin:forEnemy FromX:0 FromY:0
                 ToX:(-forEnemy.position.x + _thePlayerPlane.position.x)
                 ToY:(-forEnemy.position.y - 15)
        WithDuration:3.5];
    });
}
-(void)greenPattern:(Enemy *)forEnemy
{
    EnemyBullet * greenFrag;
    
    greenFrag = [self origin:forEnemy FromX:0 FromY:0 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_speedEnemyBullet*.30) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self brigin:greenFrag FromX:0 FromY:0 ToX:160 ToY:-700 withSpeed:_speedEnemyBullet];
        [self brigin:greenFrag FromX:0 FromY:0 ToX:-160 ToY:-700 withSpeed:_speedEnemyBullet];
                
        greenFrag.position = ccp(-50, -50);
    });
}
-(void)bluePattern:(Enemy *)forEnemy
{
    EnemyBullet * blueFrag;
    
    blueFrag = [self origin:forEnemy FromX:0 FromY:0 ToX:0 ToY:-700 WithDuration:_speedEnemyBullet];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_speedEnemyBullet*.3) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self brigin:blueFrag FromX:0 FromY:0 ToX:300 ToY:0 withSpeed:_speedEnemyBullet];
        [self brigin:blueFrag FromX:0 FromY:0 ToX:-300 ToY:0 withSpeed:_speedEnemyBullet];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_speedEnemyBullet*.4) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self brigin:blueFrag FromX:0 FromY:0 ToX:300 ToY:0 withSpeed:_speedEnemyBullet];
        [self brigin:blueFrag FromX:0 FromY:0 ToX:-300 ToY:0 withSpeed:_speedEnemyBullet];
    });
}

@end
