//
//  Button.m
//  Igra
//
//  Created by David Zagorsek on 20/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Button.h"
#import "Namespace.Igra.h"
#import "Artificial.Control.h"

@implementation Button

- (id) initWithRectangle:(Rectangle *)areaOfButton positionOfButton:(Vector2 *) positionOfButton directionOfButton:(NSString *)directionOfButton {
    self = [super init];
    
    if (self != nil) {
        area = areaOfButton;
        position = positionOfButton;
        direction = directionOfButton;
        
        NSLog(@"button konstruktor area: [w:%d, h:%d, x:%d, y:%d]",area.width, area.height, area.x, area.y);
        NSLog(@"button konstruktor pozicija: [%f, %f]",position.x, position.y);
        NSLog(@"button konstruktor direction: %@", direction);
    }
    
    return self;
}

- (id) initWithRectangle:(Rectangle *)areaOfButton directionOfButton:(NSString *)directionOfButton {
    self = [super init];
    
    if (self != nil) {
        area = areaOfButton;
        position = [[[Vector2 alloc] initWithX:area.x y:area.y] retain];
        direction = directionOfButton;
        
        NSLog(@"konsturktor area and direction ");
    }
    
    return self;
}

- (BOOL) isTouched {
    //TouchCollection *touches = [[TouchPanel getInstance] getState];
    TouchCollection *touches = [TouchPanelHelper getState]; // če imaš v Igra.m dodano komponento za touche uporabi to, če ne pa zgornjo
    for (TouchLocation *touch in touches) {

        if ([self vectorInArea:touch.position rect:area]){
            //NSLog(@" %@ button touch at [%f %f]", direction, touch.position.x, touch.position.y);
            pressed = YES;
            return YES;
        }
    }
    pressed = NO;
    return NO;
}

- (BOOL) isPressed {
    return pressed;
}

- (NSString*) getDirection {
    return direction;
}

- (Rectangle*) getArea {
    //NSLog(@"[button] area returned: %@",area);
    return area;
}

- (Vector2*) getPosition {
    //NSLog(@"[button] position returned: [%f, %f]",position.x, position.y);
    return position;
}

- (BOOL) vectorInArea:(Vector2 *)vector rect:(Rectangle *)area{
    return (vector.x >= area.x && vector.x <= area.x + area.width &&
            vector.y >= area.y && vector.y <= area.y + area.height);
}

- (void) dealloc {
    [position dealloc];
    [area dealloc];
    [super dealloc];
}

@synthesize position;

@end
