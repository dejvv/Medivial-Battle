//
//  ICollisionAlgorithm.h
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ICollisionAlgorithm

+ (void) collisionBetween:(id)item1 and:(id)item2;

+ (BOOL) detectCollisionBetween:(id)item1 and:(id)item2;
+ (void) resolveCollisionBetween:(id)item1 and:(id)item2;

@end
