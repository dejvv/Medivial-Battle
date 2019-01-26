//
//  MovementPhysics.h
//  iHockey
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator, Razum, FRI Game-Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Scene.classes.h"

@interface MovementPhysics : NSObject {

}

+ (void) simulateMovementOn:(id)item withElapsed:(float)elapsed;

@end
