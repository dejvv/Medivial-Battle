//
//  IScene.h
//  Express
//
//  Created by Matej Jan on 2.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IScene <NSObject, NSFastEnumeration, IUpdatable>

- (void) addItem:(id)item;
- (void) removeItem:(id)item;
- (void) clear;

@property (nonatomic, readonly) Event *itemAdded;
@property (nonatomic, readonly) Event *itemRemoved;

@end
