//
//  IAARectangle.h
//  Express
//
//  Created by Matej Jan on 10.1.11.
//  Copyright 2011 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IMovable.h"
#import "IMass.h"
#import "IAARectangleCollider.h"

@protocol IAARectangle <IMovable, IMass, IAARectangleCollider>

@end
