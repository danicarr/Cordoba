//
//  Marble.m
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Marble.h"
#import "GamePlay.h"

@implementation Marble{
    
    CCActionMoveTo * moveM1;
    CCActionMoveTo * moveM2;
    CCActionMoveTo * moveM3;
    CCActionSequence * moveM4;
    CCActionCallBlock * clean;
    
}

-(void) moveMarble: (CCTime)interval :(CCNode*)a :(CCNode*)b :(CCNode*) content{
    moveM1 = [CCActionMoveTo actionWithDuration:(interval) position: a.position];
    moveM2 = [CCActionMoveTo actionWithDuration:(interval) position: b.position];
    clean= [CCActionCallBlock actionWithBlock:^{
        [content removeChild:self];
        [self.gameplay removeMarble:(self)];
    }];
    
    moveM4 = [CCActionSequence actions:moveM1, moveM2, clean, nil];
    
    [self runAction: moveM4];
    
}


@end
