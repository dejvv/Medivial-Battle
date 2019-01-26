//
//  GridScene.h
//  Express
//
//  Created by Matej Jan on 7.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SimpleScene.h"

@interface GridScene : SimpleScene {
	NSMutableDictionary *grid;
}

- (NSArray*) getItemsAt:(XniPoint*)gridCoordinate;
- (NSArray*) getItemsAround:(XniPoint*)gridCoordinate neighbourDistance:(int)distance;

// Override this if you calculate grid coordinates form something other than IPosition or Vector2.
- (XniPoint*) calculateGridCoordinateForItem:(id)item;

@end
