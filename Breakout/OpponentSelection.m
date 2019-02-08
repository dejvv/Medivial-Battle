//
//  OpponentSelection.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import "OpponentSelection.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Namespace.Igra.h"


@implementation OpponentSelection

- (void) initialize {
    [super initialize];
    // Text
    title = [[Label alloc] initWithFont:fivexfive text:@"Choose opponent to battle" position:[Vector2 vectorWithX:480 y:50]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:3];
    [scene addItem:title];
    
    // Buttons
    opp1 = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:300 y:200 width:480 height:32]
                                     background:buttonBackground font:fivexfive text:@"Noob"];
    opp1.label.position.x = opp1.inputArea.x + 20;
    [opp1.backgroundImage setScaleUniform:3];
    [scene addItem:opp1];
    
    opp2 = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:300 y:250 width:480 height:32]
                                     background:buttonBackground font:fivexfive text:@"..."];
    opp2.label.position.x = opp2.inputArea.x + 20;
    opp2.backgroundColor = [Color dimGray];
    opp2.enabled = NO;
    [opp2.backgroundImage setScaleUniform:3];
    [scene addItem:opp2];
    
    opp3 = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:300 y:300 width:480 height:32]
                                     background:buttonBackground font:fivexfive text:@"..."];
    opp3.label.position.x = opp3.inputArea.x + 20;
    opp3.backgroundColor = [Color dimGray];
    opp3.enabled = NO;
    [opp3.backgroundImage setScaleUniform:3];
    [scene addItem:opp3];
    
    [scene addItem:back];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    //if (opponentButton[i].wasReleased) {
    //        Gameplay *gameplay = [[[Gameplay alloc] initSinglePlayerWithGame:self.game
    //                                                              levelClass:levelClass
    //                                                                 aiClass:opponentClass] autorelease];
    //    Gameplay *gameplay = [[[Gameplay alloc] initWithGame:igra] autorelease];
    //    [igra pushState:gameplay];
    //}
}

- (void) dealloc
{
    [title release];
    [super dealloc];
}

@end
