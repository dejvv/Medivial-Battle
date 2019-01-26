//
//  Button.h
//  Igra
//
//  Created by David Zagorsek on 20/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Input.Touch.h"
#import "Namespace.Igra.h"
#import "Position.h"

/**
Represents command button.
If user touched button, it returns x and y of touch, so button has to check whether there were any touch.
 */
@interface Button : NSObject<IPosition> {
    Rectangle *area; // stores x, y, width and height
    NSString *direction; // left, right or up
    BOOL pressed;
}

- (id) initWithRectangle:(Rectangle *)areaOfButton positionOfButton:(Vector2 *) positionOfButton directionOfButton:(NSString *) directionOfButton;
- (id) initWithRectangle:(Rectangle *)areaOfButton directionOfButton:(NSString *) directionOfButton;
- (BOOL) isTouched;
- (BOOL) isPressed;
- (BOOL) vectorInArea:(Vector2 *)vector rect:(Rectangle *)area;
- (NSString*) getDirection;
- (Rectangle*) getArea;
- (Vector2*) getPosition;

@end
