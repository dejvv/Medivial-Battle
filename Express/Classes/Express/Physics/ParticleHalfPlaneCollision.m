//
//  ParticleHalfPlaneCollision.m
//  Express
//
//  Created by Matej Jan on 10.1.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "ParticleHalfPlaneCollision.h"

#import "Express.Scene.Objects.h"
#import "Express.Physics.h"
#import "Express.Math.h"

@implementation ParticleHalfPlaneCollision

+ (BOOL) detectCollisionBetween:(id<IParticleCollider>)particle and:(id<IHalfPlaneCollider>)halfPlane {
	float nearPoint = [Vector2 dotProductOf:particle.position with:halfPlane.halfPlane.normal] - particle.radius;
	return nearPoint < halfPlane.halfPlane.distance;
}

+ (void) resolveCollisionBetween:(id<IParticleCollider>)particle and:(id<IHalfPlaneCollider>)halfPlane {
	// RELAXATION STEP
	
	// First we relax the collision, so the two objects don't collide any more.
	float nearPoint = [Vector2 dotProductOf:particle.position with:halfPlane.halfPlane.normal] - particle.radius;
	float relaxDistance = nearPoint - halfPlane.halfPlane.distance;
	Vector2 *relaxDistanceVector = [Vector2 multiply:halfPlane.halfPlane.normal by:relaxDistance]; 	
	
	[Collision relaxCollisionBetween:particle and:halfPlane by:relaxDistanceVector];
	
	// ENERGY EXCHANGE STEP
	
	// In a collision, energy is exchanged only along the collision normal.
	// For particles this is simply the line between both centers.
	Vector2 *collisionNormal = [[Vector2 vectorWithVector:relaxDistanceVector] normalize];
	Vector2 *pointOfImpact = [Vector2 add:particle.position to:[Vector2 multiply:collisionNormal by:relaxDistance + particle.radius]];
	[Collision exchangeEnergyBetween:particle and:halfPlane along:collisionNormal pointOfImpact:pointOfImpact];
}

@end
