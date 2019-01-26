//
//  AnimatedSprite.h
//  Express
//
//  Created by Matej Jan on 27.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnimatedSpriteFrame;
@class Sprite;

@interface AnimatedSprite : NSObject {
	NSMutableArray *frames;
	NSTimeInterval duration;
	BOOL looping;
}

- (id) initWithDuration:(NSTimeInterval)theDuration;
				
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) BOOL looping;

- (void) addFrame:(AnimatedSpriteFrame*)frame;

- (Sprite*) spriteAtTime:(NSTimeInterval)time;

@end
