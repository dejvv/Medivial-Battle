//
//  MainMenu.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import "MainMenu.h"

#import "Retronator.Xni.Framework.Content.h"

#import "Namespace.Igra.h"

@implementation MainMenu

- (void) initialize {
    [super initialize];
    // Background
    Texture2D *tableTexture = [[self.game.content load:@"background_big"] autorelease];
    background = [[Image alloc] initWithTexture:tableTexture position:[Vector2 vectorWithX:-0 y:0]];
    [scene addItem:background];
    
    // Text
    title = [[Label alloc] initWithFont:fivexfive text:@"Medivial Battle" position:[Vector2 vectorWithX:480 y:50]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:3];
    [scene addItem:title];
    
    // Buttons
    play = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:300 y:200 width:480 height:32]
                                          background:buttonBackground font:fivexfive text:@"Play"];
    play.label.position.x = play.inputArea.x + 20;
    //[play.label setScaleUniform:3];
    //play.label.horizontalAlign = HorizontalAlignCenter;
    [play.backgroundImage setScaleUniform:3];
    [scene addItem:play];
    
    opponents = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:300 y:300 width:480 height:32]
                                         background:buttonBackground font:fivexfive text:@"Opponents"];
    [opponents.backgroundImage setScaleUniform:3];
    opponents.label.position = [Vector2 vectorWithX:opponents.inputArea.x + 20 y: opponents.label.position.y];
    //opponents.label.horizontalAlign = HorizontalAlignCenter;
    [scene addItem:opponents];
    
    settings = [[ButtonHud alloc] initWithInputArea:[Rectangle rectangleWithX:300 y:400 width:480 height:32]
                                     background:buttonBackground font:fivexfive text:@"Scores"];
    settings.label.position.x = settings.inputArea.x + 20;
    [settings.backgroundImage setScaleUniform:3];
    [scene addItem:settings];
}

- (void) activate {
    [super activate];
//    [SoundEngine playThatSong:SongTypeMenu];
}

- (void) deactivate {
//    [SoundEngine stopThatSong];
    [super deactivate];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
//    NSLog(@"[MainMenu updateWithGameTime] works");
    [super updateWithGameTime:gameTime];
    
    GameState *newState = nil;
    
    if (play.wasReleased) {
        NSLog(@"[MainMenu updateWithGameTime] play was released!");
        newState = [[[PlayGame alloc] initWithGame:self.game] autorelease];
    } else if (opponents.wasReleased) {
        NSLog(@"[MainMenu updateWithGameTime] opponents was released!");
        newState = [[[OpponentSelection alloc] initWithGame:self.game] autorelease];
    } else if (settings.wasReleased) {
        NSLog(@"[MainMenu updateWithGameTime] settings was released!");
        newState = [[[Settings alloc] initWithGame:self.game] autorelease];
    }

    if (newState) {
        [igra pushState:newState];
    }
}

- (void) dealloc
{
    [background release];
    
    [title release];
    
    [play release];
    [opponents release];
    [settings release];
    
    [super dealloc];
}


@end
