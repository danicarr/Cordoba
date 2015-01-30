//
//  GamePlay.h
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@class Marble;
@class Log1;

@interface GamePlay : CCNode

@property (nonatomic,assign) int points;

-(void) removeMarble: (Marble*) marbs;
-(void) removeLog: (Log1*) log;

@end
