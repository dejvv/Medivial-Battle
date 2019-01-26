//
//  ConvexPolygon.m
//  Express
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "ConvexPolygon.h"

#import "Express.Math.h"

@implementation ConvexPolygon

- (id) initWithVertices:(NSArray*)theVertices
{
	self = [super init];
	if (self != nil) {
		vertices = [[NSArray alloc] initWithArray:theVertices];
		
		NSMutableArray* theEdges = [NSMutableArray array];
		NSMutableArray* theHalfPlanes = [NSMutableArray array];
		
		for (int i = 0; i < vertices.count; i++) {
			int j = (i + 1) % vertices.count;
			
			Vector2 *edge = [Vector2 subtract:[vertices objectAtIndex:j] by:[vertices objectAtIndex:i]];
			[theEdges addObject:edge];
			
			Vector2 *normal = [[Vector2 vectorWithX:edge.y y:-edge.x] normalize];
			float distance = [Vector2 dotProductOf:[vertices objectAtIndex:i] with:normal];
			[theHalfPlanes addObject:[HalfPlane halfPlaneWithNormal:normal distance:distance]];
		}
		
		edges = [[NSArray alloc] initWithArray:theEdges];
		halfPlanes = [[NSArray alloc] initWithArray:theHalfPlanes];
	}
	return self;
}

+ (ConvexPolygon*) polygonWithVertices:(NSArray*)theVertices {
	return [[[ConvexPolygon alloc] initWithVertices:theVertices] autorelease];
}

@synthesize vertices, edges, halfPlanes;

- (void) dealloc
{
	[vertices release];
	[edges release];
	[halfPlanes release];
	[super dealloc];
}


@end
