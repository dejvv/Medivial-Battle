//
//  ConvexPolygon.h
//  Express
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvexPolygon : NSObject {
	NSArray *vertices;
	NSArray *edges;
	NSArray *halfPlanes;
}

- (id) initWithVertices:(NSArray*)theVertices;

+ (ConvexPolygon*) polygonWithVertices:(NSArray*)theVertices;

@property (nonatomic, readonly) NSArray *vertices;
@property (nonatomic, readonly) NSArray *edges;
@property (nonatomic, readonly) NSArray *halfPlanes;

@end
