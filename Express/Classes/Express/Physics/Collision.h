//
//  Collision.h
//  Express
//
//  Created by Matej Jan on 9.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Collision : NSObject {

}

+ (void) collisionBetween:(id)item1 and:(id)item2;

+ (BOOL) shouldResolveCollisionBetween:(id)item1 and:(id)item2;
+ (void) reportCollisionBetween:(id)item1 and:(id)item2;

+ (void) collisionBetween:(id)item1 and:(id)item2 usingAlgorithm:(Class)collisionAlgorithm;

+ (void) relaxCollisionBetween:(id)item1 and:(id)item2 by:(Vector2*)relaxDistance;

+ (void) exchangeEnergyBetween:(id)item1 and:(id)item2 along:(Vector2*)collisionNormal pointOfImpact:(Vector2*)pointOfImpact;

@end
