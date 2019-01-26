//
//  Lifetime.h
//  Express
//
//  Created by Matej Jan on 27.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lifetime : NSObject {
	NSTimeInterval start;
	NSTimeInterval duration;
	
	NSTimeInterval progress;
}

- (id) initWithStart:(NSTimeInterval)theStart duration:(NSTimeInterval)theDuration;

@property (nonatomic, readonly) NSTimeInterval start;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) NSTimeInterval progress;
@property (nonatomic, readonly) float percentage;
@property (nonatomic, readonly) BOOL isAlive;

- (void) updateWithGameTime:(GameTime *)gameTime;

@end
