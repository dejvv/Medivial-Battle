//
//  ParticleAAHalfPlaneCollision.m
//  Express
//
//  Created by Matej Jan on 10.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "ParticleAAHalfPlaneCollision.h"

#import "Express.Scene.Objects.h"
#import "Express.Physics.h"
#import "Express.Math.h"

@implementation ParticleAAHalfPlaneCollision

+ (BOOL) detectCollisionBetween:(id<IParticleCollider>)particle and:(id<IAAHalfPlaneCollider>)aaHalfPlane {
	switch (aaHalfPlane.aaHalfPlane.direction) {
		default:
		case AxisDirectionPositiveX:
			return particle.position.x - particle.radius < aaHalfPlane.aaHalfPlane.distance;
		case AxisDirectionNegativeX:
			return particle.position.x + particle.radius > -aaHalfPlane.aaHalfPlane.distance;
		case AxisDirectionPositiveY:
			return particle.position.y - particle.radius < aaHalfPlane.aaHalfPlane.distance;
		case AxisDirectionNegativeY:
			return particle.position.y + particle.radius > -aaHalfPlane.aaHalfPlane.distance;
	}	
}

+ (void) resolveCollisionBetween:(id<IParticleCollider>)particle and:(id<IAAHalfPlaneCollider>)aaHalfPlane {
	// RELAXATION STEP
	
	// First we relax the collision, so the two objects don't collide any more.
	Vector2 *relaxDistance = nil;
	Vector2 *pointOfImpact = nil;
	switch (aaHalfPlane.aaHalfPlane.direction) {
		case AxisDirectionPositiveX:
			relaxDistance = [Vector2 vectorWithX:particle.position.x - particle.radius - aaHalfPlane.aaHalfPlane.distance y:0];
			pointOfImpact = [Vector2 vectorWithX:aaHalfPlane.aaHalfPlane.distance y:particle.position.y];
			break;
		case AxisDirectionNegativeX:
			relaxDistance = [Vector2 vectorWithX:particle.position.x + particle.radius + aaHalfPlane.aaHalfPlane.distance y:0];
			pointOfImpact = [Vector2 vectorWithX:-aaHalfPlane.aaHalfPlane.distance y:particle.position.y];
			break;
		case AxisDirectionPositiveY:
			relaxDistance = [Vector2 vectorWithX:0 y:particle.position.y - particle.radius - aaHalfPlane.aaHalfPlane.distance];
			pointOfImpact = [Vector2 vectorWithX:particle.position.x y:aaHalfPlane.aaHalfPlane.distance];
			break;
		case AxisDirectionNegativeY:
			relaxDistance = [Vector2 vectorWithX:0 y:particle.position.y + particle.radius + aaHalfPlane.aaHalfPlane.distance];
			pointOfImpact = [Vector2 vectorWithX:particle.position.x y:-aaHalfPlane.aaHalfPlane.distance];
			break;
	}
	[Collision relaxCollisionBetween:particle and:aaHalfPlane by:relaxDistance];
	
	// ENERGY EXCHANGE STEP
	
	// In a collision, energy is exchanged only along the collision normal.
	// For particles this is simply the line between both centers.
	Vector2 *collisionNormal = [[Vector2 vectorWithVector:relaxDistance] normalize];
	[Collision exchangeEnergyBetween:particle and:aaHalfPlane along:collisionNormal pointOfImpact:pointOfImpact];
	
}

@end
