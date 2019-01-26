//
//  FpsComponent.h
//  Artificial I
//
//  Created by Matej Jan on 12.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FpsComponent : GameComponent {
	int fpsCounter;
	NSDate *countStart;
}

@end
