//
//  IRotatable.h
//  Express
//
//  Created by Matej Jan on 16.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IRotation.h"
#import "IAngularVelocity.h"

@protocol IRotatable <IRotation, IAngularVelocity>

@end
