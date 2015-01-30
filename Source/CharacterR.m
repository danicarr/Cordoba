//
//  CharacterR.m
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CharacterR.h"

@implementation CharacterR{
    CCActionMoveTo *moveR1;
    CCActionMoveTo *moveR2;
    CCActionMoveTo *moveR3;
    CCActionSequence *moveR4;
    CCActionRepeatForever *moveR5;
}

-(void) moveCharacterR: (CCNode*)a :(CCNode*)b :(CCNode*)c{
    
    moveR1 = [CCActionMoveTo actionWithDuration:(5) position: a.position];
    moveR2 = [CCActionMoveTo actionWithDuration:(5) position: b.position];
    moveR3 = [CCActionMoveTo actionWithDuration:(5) position: c.position];
    
    moveR4= [CCActionSequence actions:moveR1,moveR2,moveR3,nil];
    moveR5=[CCActionRepeatForever actionWithAction:moveR4];
    
    
    [self runAction: moveR5];
    
}


-(void) dive: (int)side{
        CCActionCallBlock *sinkb= [CCActionCallBlock actionWithBlock:^{
        [self.animationManager runAnimationsForSequenceNamed:@"Sinkingbottom"];
    }];CCActionCallBlock *unsinkb= [CCActionCallBlock actionWithBlock:^{
        [self.animationManager runAnimationsForSequenceNamed:@"unSinkingbottom"];
    }];
    
    
    
    CCActionCallBlock *sinkt= [CCActionCallBlock actionWithBlock:^{
        [self.animationManager runAnimationsForSequenceNamed:@"Sinkingtop"];
    }];
    CCActionCallBlock *unsinkt= [CCActionCallBlock actionWithBlock:^{
        [self.animationManager runAnimationsForSequenceNamed:@"unSinkingtop"];
    }];
    

    CCActionFadeOut * dive= [CCActionFadeOut actionWithDuration:.1];
    CCActionFadeIn * show= [CCActionFadeIn actionWithDuration: .1];
    CCActionDelay * logtime= [CCActionDelay actionWithDuration:.5];
    
    CCActionSequence *t= [CCActionSequence actions:sinkt, dive, logtime, unsinkt, show, nil];
    
    CCActionSequence *b=[CCActionSequence actions: sinkb, dive,logtime, unsinkb, show, nil];
    if(side==1){
        [self runAction: t];
    }
    if(side==2){
        [self runAction:b];
    }
}

@end
