//
//  CharacterL.m
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CharacterL.h"

@implementation CharacterL{
    CCActionMoveTo *moveL1;
    CCActionMoveTo *moveL2;
    CCActionMoveTo *moveL3;
    CCActionSequence *moveL4;
    CCActionRepeatForever *moveL5;
    
}


-(void) moveCharacterL: (CCNode*)a :(CCNode*)b :(CCNode*)c{
    
    moveL1 = [CCActionMoveTo actionWithDuration:(5) position: a.position];
    moveL2 = [CCActionMoveTo actionWithDuration:(5) position: b.position];
    moveL3 = [CCActionMoveTo actionWithDuration:(5) position: c.position];
    
    moveL4=[CCActionSequence actions:moveL1, moveL2, moveL3, nil];
    
    moveL5=[CCActionRepeatForever actionWithAction:moveL4];
    
    [self runAction: moveL5];
}




-(void) jump{
    CCActionJumpBy *jump= [CCActionJumpBy actionWithDuration:(.8) position: ccp(0,0) height:(35) jumps:(1)];
    
    [self runAction:jump];
    
}


@end
