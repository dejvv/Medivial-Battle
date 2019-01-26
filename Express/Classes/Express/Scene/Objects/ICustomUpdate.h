//
//  ICustomUpdate.h
//  Express
//
//  Created by Matej Jan on 24.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ICustomUpdate <NSObject>

- (void) updateWithGameTime:(GameTime*)gameTime;

@end
