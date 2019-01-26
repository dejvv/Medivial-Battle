//
//  IAAHalfPlaneCollider.h
//  Express
//
//  Created by Matej Jan on 10.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Express.Math.classes.h"

@protocol IAAHalfPlaneCollider <NSObject>

@property (nonatomic, readonly) AAHalfPlane *aaHalfPlane;

@end
