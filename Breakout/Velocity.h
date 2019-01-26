//
//  Velocity.h
//  Igra
//
//  Created by David Zagorsek on 12/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Namespace.Igra.h"

/**
 Defines a class with a 2D velocity property.
 */
@protocol Velocity

@property (nonatomic, retain) Vector2 *velocity;

@end
