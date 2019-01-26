//
//  FpsComponent.m
//  Artificial I
//
//  Created by Matej Jan on 12.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "FpsComponent.h"

@implementation FpsComponent

- (void) initialize {
	countStart = [[NSDate alloc] init];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	fpsCounter++;
	NSDate *currentTime = [NSDate dateWithTimeIntervalSinceNow:0];
	NSTimeInterval countDuration = [currentTime timeIntervalSinceDate:countStart];
	if (countDuration > 1) {
		NSLog(@"FPS: %i", fpsCounter);
		fpsCounter = 0;
		[countStart release];
		countStart = [currentTime retain];
		if (gameTime.isRunningSlowly) {
			NSLog(@"Game is running slowly!");
		}
	}
}

- (void) dealloc
{
	[countStart release];
	[super dealloc];
}


@end
