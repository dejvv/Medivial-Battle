//
//  AccelerometerHelper.h
//  Artificial I
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Devices.Sensors.h"

@interface AccelerometerHelper : GameComponent {

}

+ (BOOL) valid;
+ (Vector3*) acceleration;
+ (Vector3*) gravity;
+ (Vector3*) motion;

+ (void) setGravitySmoothing:(float)value;

@end
