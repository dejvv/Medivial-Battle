//
//  AAHalfPlane.h
//  Express
//
//  Created by Matej Jan on 10.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HalfPlane.h"

@interface AAHalfPlane : HalfPlane {
	AxisDirection direction;
}

- (id) initWithDirection:(AxisDirection)theDirection distance:(float)theDistance;

+ (AAHalfPlane*) aaHalfPlaneWithDirection:(AxisDirection)theDirection distance:(float)theDistance;

@property (nonatomic) AxisDirection direction;

@end
