//
//  SimpleScene.h
//  Express
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IScene.h"
#import "GameComponent.h"

/**
 A simple scene implementation that just uses an array as its backing.
 */
@interface SimpleScene : GameComponent <IScene> {
	// A list of items currently on the scene.
	NSMutableArray *items;
	
	// A list of adds and removes to be executed on the scene.
	NSMutableArray *actions;
	
	Event *itemAdded;
	Event *itemRemoved;
}

@end
