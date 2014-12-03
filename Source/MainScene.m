//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//



#import "MainScene.h"
#import "GameCenterFiles.h"
#import <GameKit/GameKit.h>
#import "NSUserDefaults+Encryption.h"

BOOL _isMuteOn;

@implementation MainScene
{
    CCLabelTTF * _playerScore;
    CCLabelTTF * _gameOver;
    CCLabelTTF * _muteText;
}
 
-(void)ChangeBackToGamePlay
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"GamePlay"]];
}

-(void)onEnterTransitionDidFinish
{
    GameCenterFiles * gameCenter = [[GameCenterFiles alloc] init];
    
    // death music
    [[OALSimpleAudio sharedInstance] stopAllEffects];
    [[OALSimpleAudio sharedInstance] playBg:@"victory.wav"];
    
    // check to see whether the game is muted and set label accordingly
    [super onEnterTransitionDidFinish];
    
    if (_isMuteOn)
    {
        _muteText.string = @"UNMUTE";
    }
    else
    {
        _muteText.string = @"MUTE";
        
    }
    
    // encrypt the user's score, so not tampering or cheating takes place
    [[NSUserDefaults standardUserDefaults] setObjectEncrypted:@(self.alienArmada) forKey:@"soiLeaderBoard"];
    
    //show validation to the user
    NSString * score = [NSString stringWithFormat:@"%d of 222 enemies survived", self.alienArmada];
   
    _playerScore.string = score;
    NSNumber * yourScore = [NSNumber numberWithInt:self.alienArmada];
    
    // variables for analytics and leaderboard
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: yourScore, @"score", nil];
    [MGWU logEvent:@"score: " withParams:params];
    [gameCenter reportScore:self.alienArmada forLeaderboardID:@"soiLeaderBoard"];
    
    if ( (self.alienArmada) < 0 )
    {
        _gameOver.string = @"YOU WIN!";
    }
}

- (void) showLeaderboard: (NSString*) leaderboardID
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeToday;
        gameCenterController.leaderboardCategory = leaderboardID;
        
        //stop animation because it will crash if home button is pressed, without the code
        [[CCDirector sharedDirector] stopAnimation];
        
        [[CCDirector sharedDirector] presentViewController: gameCenterController animated: YES completion:nil];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [[CCDirector sharedDirector] dismissViewControllerAnimated:YES completion:nil];
    //resume game, when you come back in from somewhere else that isnt shape of infinity
    [[CCDirector sharedDirector] startAnimation];
}

// when you press on the leaderboard button
-(void)leaderBoardButton
{
    [self showLeaderboard:@"soiLeaderBoard"];
}

//when you press on the share button
-(void)shareButton
{
    [MGWU logEvent:@"share button pressed" withParams:nil];

    NSString *text = @"Your pitiful attempt ended in failure";
    NSURL *url = [NSURL URLWithString:@"http://roadfiresoftware.com/2014/02/how-to-add-facebook-and-twitter-sharing-to-an-ios-app/"];
    //UIImage *image = [UIImage imageNamed:@"roadfire-icon-square-200"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url, /*image*/]
     applicationActivities:nil];
    
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    
    [[CCDirector sharedDirector] presentViewController:controller animated:YES completion:nil];
}

// when you press on the mute button
-(void)doMute
{
    if (!_isMuteOn)
    {
        _isMuteOn = TRUE;
        [[OALSimpleAudio sharedInstance] setMuted:_isMuteOn];
        _muteText.string = @"UNMUTE";
    }
    else
    {
        _isMuteOn = FALSE;
        //[_defaultIsMuteOn setBool:FALSE forKey:@"sound off"];
        [[OALSimpleAudio sharedInstance] setMuted:_isMuteOn];
        _muteText.string = @"MUTE";
    }
}

@end
