//
//  LevelLimit.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import "LevelLimit.h"

#import "Namespace.Igra.h"

@implementation LevelLimit

- (id) initWithLimit:(AAHalfPlane *)theLimit isDeadly:(BOOL)isDeadly
{
    self = [super init];
    if (self != nil) {
        limit = [theLimit retain];
        deadly = isDeadly;
    }
    return self;
}

@synthesize scene;

- (AAHalfPlane *) aaHalfPlane {
    return limit;
}

- (HalfPlane *) halfPlane {
    return limit;
}

- (BOOL) collidingWithItem:(id)item {
    if (deadly) {
        [scene removeItem:item];
    }
    
    return !deadly;
}

- (void) dealloc
{
    [scene release];
    [limit release];
    [super dealloc];
}

@end
