//
//  CollisionAlgorithm.m
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "CollisionAlgorithm.h"

#import "Express.Physics.h"

@implementation CollisionAlgorithm

+ (void) collisionBetween:(id)item1 and:(id)item2 {
	[Collision collisionBetween:item1 and:item2 usingAlgorithm:self];
}

+ (BOOL) detectCollisionBetween:(id)item1 and:(id)item2 {return NO;}
+ (void) resolveCollisionBetween:(id)item1 and:(id)item2 {}

@end
