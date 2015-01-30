//
//  Log1.m
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Log1.h"
#import "GamePlay.h"

@implementation Log1{
    
    CCActionMoveTo *moveL1a;
    CCActionMoveTo *moveL1b;
    CCActionMoveTo *moveL1c;
    CCActionSequence * moveL1seq;
    CCActionCallBlock * clean;
    
}

-(void) moveLog1: (CCTime)interval :(CCNode*)a :(CCNode*)b :(CCNode*)c :(CCNode*)content{
    moveL1b = [CCActionMoveTo actionWithDuration:(interval) position: a.position];
    moveL1a = [CCActionMoveTo actionWithDuration:(interval) position: b.position];
    moveL1c = [CCActionMoveTo actionWithDuration:(interval) position: c.position];
    
    clean= [CCActionCallBlock actionWithBlock:^{
        [self.gameplay removeLog: self];
        [content removeChild:self];
    }];
    
    moveL1seq = [CCActionSequence actions: moveL1b, moveL1a, moveL1c, clean, nil];
    
    [self runAction: moveL1seq];
}

@end
