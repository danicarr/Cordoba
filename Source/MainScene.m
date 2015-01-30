#import "MainScene.h"

@implementation MainScene


-(void) play{
   CCLOG(@"Play button pressed");
    
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    [[OALSimpleAudio sharedInstance] stopBg];
    [[OALSimpleAudio sharedInstance] setBgVolume:0];
    [[OALSimpleAudio sharedInstance] playBg:@"Albeniz_Leyenda.caf" loop:TRUE ];
    [[OALSimpleAudio sharedInstance].backgroundTrack fadeTo:1.0f duration:3.0f target:nil selector:nil];
     
}

-(void) onEnter{
    [[OALSimpleAudio sharedInstance] playBg:@"granada.caf" loop:TRUE ];
    [super onEnter];
}
@end
