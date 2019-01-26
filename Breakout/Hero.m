//
//  Player.m
//  Igra
//
//  Created by David Zagorsek on 07/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

//#import "Hero.h"
#import "Namespace.Igra.h"


@implementation Hero

- (id) init
{
    self = [super init];
    if (self != nil) {
    }
    return self;
}

- (BOOL) collidingWithItem:(id)item {
    if(([item isKindOfClass:[Enemy class]])){
        //Enemy *e = item;
        //NSLog(@"hero coliding with enemy, hero cords:[%f,%f], enemy cords:[%f, %f]",self.position.x, self.position.y, e.position.x, e.position.y);
    }
    //if([item isKindOfClass:[LevelLimit class]])
        //NSLog(@"hero coliding with levelLimit pos: %f %f", self.position.x, self.position.y);
    return !([item isKindOfClass:[Enemy class]]);
}

- (void) collidedWithItem:(id)item {
    if ([item isKindOfClass:[FireBall class]] || [item isKindOfClass:[ItemSword class]]){
        if (!blockAttack) {
            health -= [item getDamagePower];
            NSLog(@"hero hit, health remaining: %f", health);
            if (health <= 0) {
                NSLog(@"hero died");
                [self.scene removeItem:self.myWeapon];
                [self.scene removeItem:self];
            }
        }
    } else if([item isKindOfClass:[LevelLimit class]]) {
       //self.velocity.x *= -1;
//        NSLog(@"hero coliding with levelLimit pos: %f %f", self.position.x, self.position.y);
    }
}

- (void) updateWithGameTime:(GameTime*)gameTime {
    [super updateWithGameTime:gameTime];
}

- (void) dealloc {
    [super dealloc];
}

@end
