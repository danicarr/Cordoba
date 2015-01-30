//
//  Marble.h
//  InfiniteTriangle
//
//  Created by danicarr on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@class GamePlay;

@interface Marble : CCSprite

-(void) moveMarble: (CCTime)interval :(CCNode*)a :(CCNode*)b :(CCNode*) content;

@property (nonatomic, strong) GamePlay* gameplay;

@end
