//
//  MovementPhysics.m
//  iHockey
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator, Razum, FRI Game-Team. All rights reserved.
//

#import "Express.Scene.h"
#import "Express.Scene.Objects.h"
#import "MovementPhysics.h"

@implementation MovementPhysics

+ (void) simulateMovementOn:(id)item withElapsed:(float)elapsed {
	id<IMovable> movable = [item conformsToProtocol:@protocol(IMovable)] ? item : nil;
	id<IRotatable> rotatable = [item conformsToProtocol:@protocol(IRotatable)] ? item : nil;
    
	
	if (movable) {
		[movable.position add:[Vector2 multiply:movable.velocity by:elapsed]];
	}	
	
	if (rotatable) {
		rotatable.rotationAngle += rotatable.angularVelocity * elapsed;
	}
}

@end
