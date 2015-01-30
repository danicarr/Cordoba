//
//  Log1.h
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@class GamePlay;

@interface Log1 : CCSprite

-(void) moveLog1: (CCTime)interval :(CCNode*)a :(CCNode*)b :(CCNode*)c :(CCNode*)content;

@property (nonatomic, strong) GamePlay* gameplay;

@end
