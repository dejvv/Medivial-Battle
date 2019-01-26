//
//  AccelerometerHelper.m
//  Artificial I
//
//  Created by Matej Jan on 15.2.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import "AccelerometerHelper.h"

@implementation AccelerometerHelper

static Accelerometer *accelerometer;

static Vector3 *acceleration;
static Vector3 *gravity;
static Vector3 *motion;
static BOOL valid;
static float gravitySmoothing = 0.9;

- (id) initWithGame:(Game *)theGame {
    if (self = [super initWithGame:theGame]) {
        acceleration = [[Vector3 alloc] init];
        gravity = [[Vector3 alloc] initWithX:0 y:-1 z:0];
        motion = [[Vector3 alloc] init];
		
		accelerometer = [[Accelerometer alloc] init];
		[accelerometer.readingChanged subscribeDelegate:[Delegate delegateWithTarget:self Method:@selector(handleAccelerationUpdated:eventArgs:)]];	
		[accelerometer start];
    }
    return self;
}

+ (BOOL) valid {
    return valid;
}

+ (Vector3*) acceleration {
    return [Vector3 vectorWithVector:acceleration];
}

+ (Vector3*) gravity {
    return [[Vector3 vectorWithVector:gravity] normalize];
}

+ (Vector3*) motion {
    return [Vector3 vectorWithVector:motion];
}

+ (void) setGravitySmoothing:(float)value {
    gravitySmoothing = value;
}

- (void) handleAccelerationUpdated:(Accelerometer*)sender eventArgs:(AccelerometerReadingEventArgs*)e {
    Vector3 *reading = [Vector3 vectorWithX:e.x y:e.y z:e.z];
	
	// First update.
    if (!valid) {
        [acceleration set:reading];
        [gravity set:reading];
        valid = YES;
        return;
    }
    
    // Smoothed updates.
    [acceleration set:reading];
    [[gravity multiplyBy:gravitySmoothing] add:[Vector3 multiply:acceleration by:(1-gravitySmoothing)]]; 
    [motion set:[Vector3 subtract:acceleration by:gravity]]; 
}

@end
