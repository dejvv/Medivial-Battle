//
//  AARectangleAAHalfPlaneCollision.m
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "AARectangleAAHalfPlaneCollision.h"

#import "Express.Scene.Objects.h"
#import "Express.Physics.h"
#import "Express.Math.h"

@implementation AARectangleAAHalfPlaneCollision

+ (BOOL) detectCollisionBetween:(id<IAARectangleCollider>)aaRectangle and:(id<IAAHalfPlaneCollider>)aaHalfPlane {
	switch (aaHalfPlane.aaHalfPlane.direction) {
		default:
		case AxisDirectionPositiveX:
			return aaRectangle.position.x - aaRectangle.width/2 < aaHalfPlane.aaHalfPlane.distance;
		case AxisDirectionNegativeX:
			return aaRectangle.position.x + aaRectangle.width/2 > -aaHalfPlane.aaHalfPlane.distance;
		case AxisDirectionPositiveY:
			return aaRectangle.position.y - aaRectangle.height/2 < aaHalfPlane.aaHalfPlane.distance;
		case AxisDirectionNegativeY:
			return aaRectangle.position.y + aaRectangle.height/2 > -aaHalfPlane.aaHalfPlane.distance;
	}	
}

+ (void) resolveCollisionBetween:(id<IAARectangleCollider>)aaRectangle and:(id<IAAHalfPlaneCollider>)aaHalfPlane {
	// RELAXATION STEP
	
	// First we relax the collision, so the two objects don't collide any more.
	Vector2 *relaxDistance = nil;
	switch (aaHalfPlane.aaHalfPlane.direction) {
		case AxisDirectionPositiveX:
			relaxDistance = [Vector2 vectorWithX:aaRectangle.position.x - aaRectangle.width/2 - aaHalfPlane.aaHalfPlane.distance y:0];
			break;
		case AxisDirectionNegativeX:
			relaxDistance = [Vector2 vectorWithX:aaRectangle.position.x + aaRectangle.width/2 + aaHalfPlane.aaHalfPlane.distance y:0];
			break;
		case AxisDirectionPositiveY:
			relaxDistance = [Vector2 vectorWithX:0 y:aaRectangle.position.y - aaRectangle.height/2 - aaHalfPlane.aaHalfPlane.distance];
			break;
		case AxisDirectionNegativeY:
			relaxDistance = [Vector2 vectorWithX:0 y:aaRectangle.position.y + aaRectangle.height/2 + aaHalfPlane.aaHalfPlane.distance];
			break;
	}
	[Collision relaxCollisionBetween:aaRectangle and:aaHalfPlane by:relaxDistance];
	
	// ENERGY EXCHANGE STEP
	
	// In a collision, energy is exchanged only along the collision normal.
	// For particles this is simply the line between both centers.
	Vector2 *collisionNormal = [[Vector2 vectorWithVector:relaxDistance] normalize];
	[Collision exchangeEnergyBetween:aaRectangle and:aaHalfPlane along:collisionNormal pointOfImpact:nil];
	
}

@end
