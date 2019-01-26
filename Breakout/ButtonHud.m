//
//  ButtonHud.m
//  MedivialBattle
//
//  Created by David Zagorsek on 25/12/2018.
//

#import "ButtonHud.h"

#import "Retronator.Xni.Framework.Input.Touch.h"

#import "Artificial.Control.h"

@implementation ButtonHud

- (id) initWithInputArea:(Rectangle*)theInputArea
              background:(Texture2D*)background
                    font:(SpriteFont*)font
                    text:(NSString*)text
{
    self = [super init];
    if (self != nil) {
        
        inputArea = [theInputArea retain];
        enabled = YES;
        
        backgroundImage = [[Image alloc] initWithTexture:background position:[Vector2 vectorWithX:inputArea.x y:inputArea.y]];
        label = [[Label alloc] initWithFont:font
                                       text:text
                                   position:[Vector2 vectorWithX:inputArea.x + 10 y:inputArea.y + inputArea.height]];
        label.verticalAlign = VerticalAlignMiddle;
        
        self.backgroundColor = [Color white];
        self.backgroundHoverColor = [Color dimGray];
        
        self.labelColor = [Color black];
        self.labelHoverColor = [Color white];
        
    }
    return self;
}

- (id) initWithInputArea:(Rectangle*)theInputArea background:(Texture2D*)background rotation:(float)theRotation {
    self = [super init];
    if (self != nil) {
        inputArea = theInputArea;
        enabled = YES;
        backgroundImage = [[Image alloc] initWithTexture:background position:[Vector2 vectorWithX:inputArea.x y:inputArea.y]];
        [backgroundImage setRotation:theRotation];
        self.backgroundColor = [Color white];
        self.backgroundHoverColor = [Color dimGray];
        // label is not used
        label = [[Label alloc] init];
    }
    return self;
}

@synthesize inputArea, enabled, isDown, wasPressed, wasReleased, scene, backgroundImage, label;
@synthesize labelColor, labelHoverColor, backgroundColor, backgroundHoverColor;

- (void) setLabelColor:(Color *)value {
    [value retain];
    [labelColor release];
    labelColor = value;
    label.color = labelColor;
}

- (void) setBackgroundColor:(Color *)value {
    [value retain];
    [backgroundColor release];
    backgroundColor = value;
    backgroundImage.color = backgroundColor;
}

- (void) addedToScene:(id <IScene>)theScene {
    // Add child items to scene.
    [theScene addItem:backgroundImage];
    [theScene addItem:label];
}

- (void) removedFromScene:(id <IScene>)theScene {
    // Remove child items.
    [theScene removeItem:backgroundImage];
    [theScene removeItem:label];
}

- (void) updateWithInverseView:(Matrix *)inverseView  {
    
    if (!enabled) {
        return;
    }
    
    TouchCollection *touches = [TouchPanelHelper getState];
//    TouchCollection *touches = [[TouchPanel getInstance] getState];
    if (!touches) {
        return;
    }
    
    BOOL wasDown = isDown;
    
    isDown = NO;
    wasPressed = NO;
    wasReleased = NO;
    
    for (TouchLocation *touch in touches) {
        Vector2* touchInScene = [Vector2 transform:touch.position with:inverseView];
        if ([inputArea containsVector:touchInScene] && touch.state != TouchLocationStateInvalid) {//[inputArea containsVector:touchInScene] &&
            if (touch.state == TouchLocationStatePressed) {
                pressedID = touch.identifier;
                wasPressed = YES;
            }
            
            // Only act to the touch that started the push.
            if (touch.identifier == pressedID) {
                if (touch.state == TouchLocationStateReleased) {
                    wasReleased = YES;
                } else {
                    isDown = YES;
                }
            }
        }
    }
//    NSLog(@"[buttonHud] waspressed: %d", wasPressed);
//    NSLog(@"[buttonHud] isdown: %d", isDown);
//    NSLog(@"[buttonHud] wasreleased: %d", wasReleased);
    
    if (isDown && !wasDown) {
        backgroundImage.color = backgroundHoverColor;
        label.color = labelHoverColor;
    } else if (!isDown && wasDown) {
        backgroundImage.color = backgroundColor;
        label.color = labelColor;
    }
}

- (void) dealloc
{
    [backgroundImage release];
    [label release];
    [inputArea release];
    [super dealloc];
}

@end

