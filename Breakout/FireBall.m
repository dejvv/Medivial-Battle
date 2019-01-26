//
//  FireBall.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import "FireBall.h"
#import "Namespace.Igra.h"

@implementation FireBall

- (id) init {
    self = [super self];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        radius = 16.0;
        mass = 1.0;
        damagePower = 15;
    }
    return self;
}

- (BOOL) collidingWithItem:(id)item {
    if ([item isKindOfClass:[LevelLimit class]])
        //NSLog(@"fireball coliding with levelLimit pos: %f %f", self.position.x, self.position.y);
    // Don't collide with buttons on screen
    if ([item isKindOfClass:[FireBall class]]) {
        //NSLog(@"fireball collision not detected!");
        return NO;
    }
    //NSLog(@"fireball collision detected! with: %@", [item class]);
    return YES;
}

- (void) collidedWithItem:(id)item {
    // When fireball hits object (enemy) it should disappear from the scene
    if ([item isKindOfClass:[Character class]]){
        if ([item getBlockAttack] && ![item getBlocked]) {
            [item setBlocked:YES];
            //NSLog(@"enemy blocking!");
            //self.velocity.x *= -1;
        } else {
            //NSLog(@"fireball collided with character!");
            [SoundEngine play:SoundEffectTypeFireBallHit];
            [scene removeItem:self];
        }
    } else {
        //NSLog(@"fireball collided!");
        [SoundEngine play:SoundEffectTypeFireBallHit];
        [scene removeItem:self];
    }
    
    //}
}

- (void) updateWithGameTime:(GameTime*)gameTime {
    //NSLog(@"fireball coords: [%f, %f]", position.x, position.y);
}

- (int) getDamagePower {
    return damagePower;
}

- (void) setVelocity:(Vector2 *)velocity {
    self.velocity = velocity;
}

- (NSString *) getFiredBy {
    return firedBy;
}
- (void) setFiredBy: (NSString *) fire {
    firedBy = fire;
}

@synthesize position, velocity, mass, radius, damagePower, scene;

- (void) dealloc
{
    [scene release];
    [velocity release];
    [position release];
    [super dealloc];
}

@end
