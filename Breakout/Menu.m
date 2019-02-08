//
//  Menu.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import "Menu.h"

#import "Retronator.Xni.Framework.Content.h"

#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"

#import "Namespace.Igra.h"

@implementation Menu

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] initWithGame:self.game];
        renderer = [[GuiRenderer alloc] initWithGame:self.game scene:scene gameplay:nil];
    }
    return self;
}

- (void) activate {
    NSLog(@"[Menu] activating %@", self);
    [self.game.components addComponent:scene];
    [self.game.components addComponent:renderer];
}

- (void) deactivate {
    NSLog(@"[Menu] deactivating on %@", self);
    [self.game.components removeComponent:scene];
    [self.game.components removeComponent:renderer];
}

- (void) initialize {
    // Fonts
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    fivexfive = [self.game.content load:@"5x5" processor:fontProcessor];
    fivexfive.lineSpacing = 14;
    fivexfive.spacing = 1;
    
    // Buttons
    buttonBackground = [self.game.content load:@"Button"];
    
    back = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:480 y:580 width:320 height:32]
                                  background:nil font:fivexfive text:@"Back"];
    back.labelColor = [Color white];
    back.labelHoverColor = [Color gray];
    back.label.position.x = 480;
    back.label.horizontalAlign = HorizontalAlignCenter;
    
    [super initialize];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    // Update all buttons.
    Matrix *inverseView = [Matrix invert:renderer.camera];
    for (id item in scene) {
        ButtonHud *button = [item isKindOfClass:[ButtonHud class]] ? item : nil;
        
        if (button) {
            [button updateWithInverseView:inverseView];
        }
    }
    
    if (back.wasReleased) {
        [igra popState];
    }
}

- (void) dealloc
{
    [back release];
    [buttonBackground release];
    [fivexfive release];
    [scene release];
    [renderer release];
    [super dealloc];
}

@end
