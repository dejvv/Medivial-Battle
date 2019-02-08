//
//  Player.m
//  Igra
//
//  Created by David Zagorsek on 07/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

// #import "Enemy.h"
#import "Namespace.Igra.h"

@implementation Enemy

- (id) init
{
    self = [super init];
    if (self != nil) {
    }
    return self;
}

- (BOOL) collidingWithItem:(id)item {
//    if([item isKindOfClass:[LevelLimit class]])
//        NSLog(@"enemy coliding with levelLimit pos: %f %f", self.position.x, self.position.y);
    return !([item isKindOfClass:[Hero class]]);
}

- (void) collidedWithItem:(id)item {
    if ([item isKindOfClass:[FireBall class]] || [item isKindOfClass:[ItemSword class]]){
        if (!blockAttack) {
            self.numberOfHitsReceived += 1;
            health -= [item getDamagePower];
            NSLog(@"enemy hit, health remaining: %f", health);
            if (health <= 0) {
                NSLog(@"enemy died");
                [self.scene removeItem:self.myWeapon];
                [self.scene removeItem:self];
            }
        }
    } else if([item isKindOfClass:[LevelLimit class]]) {
        if (self.velocity.y == 0){
            //NSLog(@"BEFORE enemy colided with level limit and is on ground: [%f, %f]", self.velocity.x, self.velocity.y);
            //self.velocity.x *= -1;
            //NSLog(@"AFTER enemy colided with level limit and is on ground: [%f, %f]", self.velocity.x, self.velocity.y);
        }
    }
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
}

- (void) dealloc{
    [super dealloc];
}


@end

