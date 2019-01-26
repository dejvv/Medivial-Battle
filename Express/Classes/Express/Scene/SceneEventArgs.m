//
//  SceneEventArgs.m
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SceneEventArgs.h"


@implementation SceneEventArgs

- (id) initWithItem:(id)theItem;
{
	self = [super init];
	if (self != nil) {
		item = theItem;
	}
	return self;
}

+ (SceneEventArgs*) eventArgsWithItem:(id)theItem {
	return [[[SceneEventArgs alloc] initWithItem:theItem] autorelease];
}

@synthesize item;

@end
