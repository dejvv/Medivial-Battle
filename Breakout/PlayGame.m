//
//  PlayGame.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import "PlayGame.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Namespace.Igra.h"


@implementation PlayGame

- (void) initialize {
    [super initialize];
//    [SoundEngine play:SoundEffectTypeFireBallShot];
    [SoundEngine playThatSong:SongTypeBattle];
    Gameplay *gameplay = [[[Gameplay alloc] initWithGame:igra] autorelease];
    [igra pushState:gameplay];
    
    // Text
//    title = [[Label alloc] initWithFont:fivexfive text:@"Lets play!" position:[Vector2 vectorWithX:160 y:10]];
//    title.horizontalAlign = HorizontalAlignCenter;
//    [scene addItem:title];
//    [scene addItem:back];
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
