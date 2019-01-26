//
//  Rectangle+Extensions.m
//  Artificial I
//
//  Created by Matej Jan on 29.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Rectangle+Extensions.h"


@implementation Rectangle (Extensions)

- (BOOL) containsVector:(Vector2*) value {
	return (value.x >= data.x && value.x <= data.x + data.width &&
			value.y >= data.y && value.y <= data.y + data.height);
}

@end
