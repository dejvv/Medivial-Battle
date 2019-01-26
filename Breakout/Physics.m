//
//  Physics.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import "Physics.h"

#import "Express.Physics.h"

#import "Namespace.Igra.h"

@implementation Physics

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel {
    if (self = [super initWithGame:theGame]) {
        level = theLevel;
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    // Movement, also calc gravity if it should be for item
    for (id item in level.scene) {
        [ResolveGravity resolveGravityOn:item withElapsed:gameTime.elapsedGameTime];
        [MovementPhysics simulateMovementOn:item withElapsed:gameTime.elapsedGameTime];
    }
    
    for (id item1 in level.scene) {
        // Check for collision between fireballs and enemys
        if ([item1 isKindOfClass:[FireBall class]] || [item1 isKindOfClass:[Enemy class]] || [item1 isKindOfClass:[Hero class]]) {
            for (id item2 in level.scene) {
                if (item1 != item2) {
                    [Collision collisionBetween:item1 and:item2];
                }
            }
        }
    }
}

@end
