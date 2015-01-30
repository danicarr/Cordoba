//
//  GamePlay.m
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import "CharacterL.h"
#import "CharacterR.h"
#import "Marble.h"
#import "Log1.h"

@implementation GamePlay{

    CCNode *_contentNode;
    CCNode *_aLnode;
    CCNode *_bLnode;
    CCNode *_cLnode;
    CCNode *_aRnode;
    CCNode *_bRnode;
    CCNode *_cRnode;
    CharacterL * _playerLobj;
    CharacterR * _playerRobj;
    Marble * marbleObj;
    Log1 * log1Obj;
    CCNode *junctionWater;
    CCNode *junctionGrass;
    CCLabelTTF *_scoreLabel;
    CCNode *tgTouch;
    CCNode *bgTouch;
    CCNode *twTouch;
    CCNode *bwTouch;
    CCNode *pointL;
    CCNode *pointR;
    CCNode *_wfJunc;
    CCNode *noSpawnZoneL;
    CCNode *noSpawnZoneM;
    Boolean isGameOver;
    NSMutableArray *marbles;
    NSMutableArray *logs;
    int count;
    Boolean notFirstTime;
    Boolean coolDownL;
    Boolean coolDownR;
    Boolean canDispatchM;
    Boolean canDispatchL;
    CCNode *stripes;
}

-(void) update:(CCTime)delta{
      float spawn=(float)arc4random()/10000000000;
    
    [self fixZorder];
    [self logAnimation];
    
    float  intervalMarble=(7-(.2*self.points));
    float intervalLog=(7-(.2*self.points));
    if(!canDispatchM){
        if((spawn>.2 && spawn<.25) && !(CGRectIntersectsRect(_playerLobj.boundingBox, noSpawnZoneM.boundingBox))){
            [self createMarbleObstacle: intervalMarble];
        }
        canDispatchM=true;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        canDispatchM=false;});
    }

    
    if(!canDispatchL){
        if((spawn>0&& spawn <.05) && !(CGRectIntersectsRect(_playerRobj.boundingBox, noSpawnZoneL.boundingBox))){
        [self createLog1Obstacle: intervalLog];
        }
        canDispatchL=true;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        canDispatchL=false;});
    }

    if(!isGameOver){
        [self gameOver];
    }

    [self updatePoints];
}


-(void) logAnimation{
    for(int j=0; j<logs.count;j++){
        if(CGRectIntersectsRect(_bRnode.boundingBox, ((Log1*)[logs objectAtIndex:j]).boundingBox)){
            ((CCSprite *)[logs objectAtIndex:j]).spriteFrame = [CCSpriteFrame frameWithImageNamed:@"Assets 3/Log1new.png"];
        }
        if(CGRectIntersectsRect(_aRnode.boundingBox, ((Log1*)[logs objectAtIndex:j]).boundingBox)){
            ((CCSprite *)[logs objectAtIndex:j]).spriteFrame= [CCSpriteFrame frameWithImageNamed:@"Assets 3/Log3.png"];
        }
    }
}


- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint loctouch= [touch locationInNode:self];
    
    CGRect leftBox= CGRectMake(0,0,[CCDirector sharedDirector].viewSize.width/2, [CCDirector sharedDirector].viewSize.height);
    CGRect rightBox= CGRectMake([CCDirector sharedDirector].viewSize.width/2,0, [CCDirector sharedDirector].viewSize.width/2,[CCDirector sharedDirector].viewSize.height);
    
    
    if(CGRectContainsPoint(leftBox, loctouch) && (CGRectIntersectsRect(_playerLobj.boundingBox,tgTouch.boundingBox) || CGRectIntersectsRect(_playerLobj.boundingBox, bgTouch.boundingBox))){
        if(!coolDownL){
            [_playerLobj jump];
        }
        coolDownL=true;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            coolDownL=false;
        });
    }
    
    int side;
    if(CGRectIntersectsRect(_playerRobj.boundingBox, bwTouch.boundingBox)){
        side=2;
    }
    if(CGRectIntersectsRect(_playerRobj.boundingBox, twTouch.boundingBox)){
        side=1;
    }
    if(CGRectContainsPoint(rightBox, loctouch)){
        if(!coolDownR){
            [_playerRobj dive: side];
        }
        coolDownR=true;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            coolDownR=false;});
    }
}

-(void) updatePoints{
    if((CGRectIntersectsRect(_playerLobj.boundingBox, pointL.boundingBox)) ){
        notFirstTime=true;
    }
    if(notFirstTime){
        count++;
        notFirstTime=false;
        
    }
    if(count==96){
        self.points++;
        count=0;
    }
}


-(void) exitScene{
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"MainScene"]];
}

-(void) runCharacters{
    [self createCharacterR];
    [self createCharacterL];

    [self moveCharacters];
}


-(void) moveCharacters{
    [_playerLobj moveCharacterL:_bLnode :_cLnode :_aLnode];
    [_playerRobj moveCharacterR:_bRnode :_cRnode :_aRnode];
}


-(void) createMarbleObstacle :(CCTime) randomTimeInterval{
    marbleObj = (Marble *)[CCBReader load: @"Marble"];
    marbleObj.position= _cLnode.position;
    marbleObj.gameplay=self;
    marbleObj.zOrder=2;
    [marbles addObject: marbleObj];
    
    [_contentNode addChild: marbleObj];
    
    CCLOG(@"marbles array: %@", marbles);
    [marbleObj moveMarble:(randomTimeInterval) :_bLnode: _aLnode: _contentNode];
    
}


-(void) createLog1Obstacle :(CCTime) randomTimeInterval{
    log1Obj= (Log1 *)[CCBReader load: @"Log1"];
    [log1Obj setZOrder:4];
    log1Obj.position= _cRnode.position;
   
    [logs addObject: log1Obj];
    [_contentNode addChild:log1Obj];
    
    CCLOG(@"logs array order: %@", logs);
    
    [log1Obj moveLog1:randomTimeInterval :_bRnode :_aRnode :_cRnode :_contentNode];
    
}

-(void) createCharacterL{
    _playerLobj= (CharacterL *)[CCBReader load:@"CharacterL"];
    _playerLobj.position= _aLnode.position;
    _playerLobj.opacity=0;
    CCActionFadeIn *b= [CCActionFadeIn actionWithDuration:.5f];
    [_contentNode addChild: _playerLobj];
    [_playerLobj setZOrder:2];
    [_playerLobj runAction: b];
}


-(void) createCharacterR{
    _playerRobj= (CharacterR *)[CCBReader load:@"CharacterR"];
    _playerRobj.position= _aRnode.position;
    _playerRobj.opacity=0;
    CCActionFadeIn *a= [CCActionFadeIn actionWithDuration:.5f];
    [_playerRobj runAction: a];
    [_playerRobj setZOrder:0];
    [_contentNode addChild: _playerRobj];
    
}

-(void) gameOver{
    if(_playerLobj!=nil && marbleObj!=nil ){
        
        for(int i=0; i<marbles.count; i++){
            if(CGRectIntersectsRect(_playerLobj.boundingBox,((Marble*)[marbles objectAtIndex:i]).boundingBox) ){
                [[OALSimpleAudio sharedInstance] playEffect:@"death.caf" loop:NO];
                [_contentNode removeChild: _playerLobj];
                isGameOver=true;
            }
        }
    }
        
    if(_playerRobj!=nil && log1Obj!=nil){
        for(int j=0; j<logs.count;j++){
        if(CGRectIntersectsRect(_playerRobj.boundingBox, ((Log1*)[logs objectAtIndex:j]).boundingBox) && _playerRobj.opacity==1 && !(CGRectIntersectsRect(((Log1*)[logs objectAtIndex:j]).boundingBox, _wfJunc.boundingBox))){
            [[OALSimpleAudio sharedInstance] playEffect:@"death.caf" loop:NO];
            [_contentNode removeChild: _playerRobj];
            isGameOver=true;
            
            }
        }
    }
    if(isGameOver){
       [self.animationManager runAnimationsForSequenceNamed:@"died"];
        [[OALSimpleAudio sharedInstance] stopBg];
    }
}


-(void) fixZorder{
    
    [stripes setZOrder: 5];
    
    if(CGRectIntersectsRect(_playerRobj.boundingBox, junctionWater.boundingBox)){
        [_playerRobj setZOrder:4];
    }
    if(CGRectIntersectsRect(_playerRobj.boundingBox, _aRnode.boundingBox)){
        [_playerRobj setZOrder:0];
    }
    for(int i=0; i<logs.count;i++){
        if(CGRectIntersectsRect(((Log1*)[logs objectAtIndex:i]).boundingBox, junctionGrass.boundingBox)){
            [[logs objectAtIndex:i] setZOrder:0];
        }
    }
}


-(void) onEnter{
    isGameOver=false;
    [junctionWater setZOrder:3];
    [junctionGrass setZOrder:1];
    marbles=[[NSMutableArray alloc] init];
    logs= [[NSMutableArray alloc] init];
    [super onEnter];
}

-(void) removeMarble: (Marble*) marbs{
    [marbles removeObject:marbs];
}

-(void) removeLog: (Log1*) log{
    [logs removeObject:log];
}

-(void) showScore{
    _scoreLabel.string= [NSString stringWithFormat:@"%d",_points];
    _scoreLabel.visible=true;
}

-(void) setPoints:(int)points{
    _points=points;
    [self showScore];
}

- (void)didLoadFromCCB {
   
    _scoreLabel.visible=true;
    self.userInteractionEnabled = TRUE;
}

@end