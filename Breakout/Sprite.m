//
//  Sprite.m
//  Express
//
//  Created by Matej Jan on 26.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Sprite.h"


@implementation Sprite

@synthesize texture;
@synthesize sourceRectangle;
@synthesize origin;

- (void) dealloc
{
	[texture release];
	[sourceRectangle release];
	[origin release];
	[super dealloc];
}

@end
