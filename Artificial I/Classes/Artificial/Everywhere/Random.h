//
//  Random.h
//  Artificial I
//
//  Created by Matej Jan on 19.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Random : NSObject {

}

+ (int) int;
+ (int) intLessThan:(int)maxValue;
+ (int) intGreaterThanOrEqual:(int)minValue lessThan:(int)maxValue;
+ (float) float;
+ (double) double;

@end
