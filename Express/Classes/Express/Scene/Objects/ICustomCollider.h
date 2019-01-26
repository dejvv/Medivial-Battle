//
//  ICustomCollider.h
//  Express
//
//  Created by Matej Jan on 16.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "System.h"

@protocol ICustomCollider <NSObject>

@optional
- (BOOL) collidingWithItem:(id)item;
- (void) collidedWithItem:(id)item;

@end
