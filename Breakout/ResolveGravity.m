//
//  ResolveGravity.m
//  MedivialBattle
//
//  Created by David Zagorsek on 11/12/2018.
//

#import "Namespace.Igra.h"
#import "Namespace.Igra.classes.h"
#import "ResolveGravity.h"

@implementation ResolveGravity

+ (void) resolveGravityOn:(id)item withElapsed:(float)elapsed {
    id<IMovable> movable = [item conformsToProtocol:@protocol(IMovable)] ? item : nil;
    id<DGravity> gravity = [item conformsToProtocol:@protocol(DGravity)] ? item : nil;
    
    if (movable && gravity)
        [movable.velocity add:[Vector2 vectorWithX:0 y:(([Constants getInstance].gravityForce * gravity.userMass.y) / elapsed * elapsed)]];
}

@end
