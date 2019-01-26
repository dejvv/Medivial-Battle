//
//  AnimatedSpriteFrame.h
//  Express
//
//  Created by Matej Jan on 27.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Express.Graphics.classes.h"

@interface AnimatedSpriteFrame : NSObject {
	Sprite *sprite;
	NSTimeInterval start;
}

- (id) initWithSprite:(Sprite*)theSprite start:(NSTimeInterval)theStart;
+ (id) frameWithSprite:(Sprite*)theSprite start:(NSTimeInterval)theStart;

@property (nonatomic, readonly) Sprite *sprite;
@property (nonatomic, readonly) NSTimeInterval start;

@end
