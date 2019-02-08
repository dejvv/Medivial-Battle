//
//  GameState.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import "GameState.h"


@implementation GameState

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        igra = (Igra*)self.game;
    }
    return self;
}

- (void) activate {}
- (void) deactivate {}

@end
