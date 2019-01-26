//
//  ParticleConvexCollision.m
//  Express
//
//  Created by Matej Jan on 10.1.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "ParticleConvexCollision.h"

#import "Express.Scene.Objects.h"
#import "Express.Physics.h"
#import "Express.Math.h"

@interface ParticleConvexCollision ()

+ (Vector2*) calculateRelaxDistanceBetween:(id<IParticleCollider>)particle and:(id<IConvexCollider>)convex returnPointOfImpact:(Vector2*)pointOfImpact;

@end

@implementation ParticleConvexCollision

+ (BOOL) detectCollisionBetween:(id<IParticleCollider>)particle and:(id<IConvexCollider>)convex {
	Vector2 *relaxDistance = [ParticleConvexCollision calculateRelaxDistanceBetween:particle and:convex returnPointOfImpact:nil];
	return [relaxDistance lengthSquared] > 0;
}

+ (void) resolveCollisionBetween:(id<IParticleCollider>)particle and:(id<IConvexCollider>)convex {
	Vector2 *pointOfImpact = [Vector2 zero];
	Vector2 *relaxDistance = [ParticleConvexCollision calculateRelaxDistanceBetween:particle and:convex returnPointOfImpact:pointOfImpact];
	[Collision relaxCollisionBetween:particle and:convex by:relaxDistance];
	
	Vector2 *collisionNormal = [[Vector2 vectorWithVector:relaxDistance] normalize];
	[Collision exchangeEnergyBetween:particle and:convex along:collisionNormal pointOfImpact:pointOfImpact];
}

+ (Vector2*) calculateRelaxDistanceBetween:(id <IParticleCollider>)particle and:(id<IConvexCollider>)convex returnPointOfImpact:(Vector2*)pointOfImpact {
	
	// First move particle in coordinate space of the convex.
	Vector2 *offset = [convex conformsToProtocol:@protocol(IPosition)] ? ((id<IPosition>)convex).position : [Vector2 zero];
	float angle = [convex conformsToProtocol:@protocol(IRotation)] ? ((id<IRotation>)convex).rotationAngle : 0;
	Matrix *transform = [[Matrix createRotationZ:angle] multiplyBy:[Matrix createTranslationX:offset.x y:offset.y z:0]];
	
	Vector2 *relativeParticlePosition = [Vector2 transform:particle.position with:[Matrix invert:transform]];
	
	NSArray *vertices = convex.bounds.vertices;
	NSArray *halfPlanes = convex.bounds.halfPlanes;
	
	BOOL voronoiNearEdge = NO;
	
	float smallestDifference = 0;
	int smallestDifferenceIndex = 0;
	
	float smallestDistance = 0;
	int smallestDistanceIndex = 0;
	
	// Calculate overlap with all sides.
	int timesCenterUnderEdge = 0;
	for (int i = 0; i < vertices.count; i++) {
		
		// Relax distance from the plane
		HalfPlane *halfPlane = [halfPlanes objectAtIndex:i];
		
		float nearPoint = [Vector2 dotProductOf:relativeParticlePosition with:halfPlane.normal] - particle.radius;
		float relaxDifference = nearPoint - halfPlane.distance;
		if (relaxDifference > 0) return [Vector2 zero];
		
		if (i == 0 || relaxDifference > smallestDifference) {
			smallestDifference = relaxDifference;
			smallestDifferenceIndex = i;
		}
		
		// Distance to vertex
		float distance = [Vector2 subtract:[vertices objectAtIndex:i] by:relativeParticlePosition].length;
		if (i == 0 || distance < smallestDistance) {
			smallestDistance = distance;
			smallestDistanceIndex = i;
		}
		
		// Are we in the voronoi region of this edge?
		float centerDifference = [Vector2 dotProductOf:relativeParticlePosition with:halfPlane.normal] - halfPlane.distance;
		if (centerDifference > 0) {
			// Center is above edge so see if we're between start and end.
			Vector2 *edge = [convex.bounds.edges objectAtIndex:i];
			Vector2 *edgeNormal = [Vector2 normalize:edge];
			float start = [Vector2 dotProductOf:[vertices objectAtIndex:i] with:edgeNormal];
			float end = [Vector2 dotProductOf:[Vector2 add:edge to:[vertices objectAtIndex:i]] with:edgeNormal];
			float center = [Vector2 dotProductOf:relativeParticlePosition with:edgeNormal];
			if (start < center && center < end) {
				voronoiNearEdge = YES;
				
				if (smallestDifferenceIndex == i) {
					[pointOfImpact set:[Vector2 add:[vertices objectAtIndex:i] to:[Vector2 multiply:edge by:(center-start)/(end-start)]]];
				}
			}
		} else {
			timesCenterUnderEdge++;
		}
	}
	
	Vector2 *relaxDistance = nil;
	
	// Particle is under all sides.	
	if (voronoiNearEdge || timesCenterUnderEdge == [vertices count]) {
		// The edge is closer than the nearest vertex, so just relax in the direction of edge normal
		HalfPlane *nearestPlane = [halfPlanes objectAtIndex:smallestDifferenceIndex];
		relaxDistance = [Vector2 multiply:nearestPlane.normal by:smallestDifference];
	} else {
		// We are in the voronoi region next to nearest vertex.
		Vector2 *voronoiVertex = [vertices objectAtIndex:smallestDistanceIndex];
		Vector2 *voronoiNormal = [[Vector2 subtract:relativeParticlePosition by:voronoiVertex] normalize];
		
		float nearPoint = [Vector2 dotProductOf:relativeParticlePosition with:voronoiNormal] - particle.radius;
		float distance = [Vector2 dotProductOf:voronoiVertex with:voronoiNormal];
		float relaxDifference = nearPoint - distance;
		if (relaxDifference > 0) return [Vector2 zero];
		
		// Relax in the direction of voronoi vertex
		relaxDistance = [Vector2 multiply:voronoiNormal by:relaxDifference];
		[pointOfImpact set:voronoiVertex];
	}
	
	// Transform result vector back into absolute space.
	[pointOfImpact transformWith:transform];
	return [relaxDistance transformNormalWith:transform];
}

@end
