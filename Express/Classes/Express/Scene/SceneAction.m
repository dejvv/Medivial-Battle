//
//  SceneAction.m
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SceneAction.h"

@implementation SceneAction

@synthesize operation, item;

+ (SceneAction*) actionWithOperation:(SceneOperation)theOperation item:(id)theItem {
	SceneAction *action = [[[SceneAction alloc] init] autorelease];
	action.operation = theOperation;
	action.item = theItem;
	return action;
}

- (void) dealloc
{
	[item release];
	[super dealloc];
}


@end

