//
//  IRectangleCollider.h
//  Express
//
//  Created by Matej Jan on 16.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IPosition.h"
#import "IRotation.h"
#import "IRectangleSize.h"

@protocol IRectangleCollider <IPosition, IRotation, IRectangleSize>

@end
