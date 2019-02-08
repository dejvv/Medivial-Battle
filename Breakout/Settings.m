//
//  Settings.m
//  MedivialBattle
//
//  Created by David Zagorsek on 26/01/2019.
//

#import "Settings.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Namespace.Igra.h"


@implementation Settings

- (void) initialize {
    [super initialize];
//    [SoundEngine playThatSong:SongTypeMenu];
    // Text
    title = [[Label alloc] initWithFont:fivexfive text:@"Your scores" position:[Vector2 vectorWithX:480 y:50]];
    title.horizontalAlign = HorizontalAlignCenter;
    [title setScaleUniform:3];
    [scene addItem:title];
    
    [scene addItem:back];
    
    [self loadScores];
    
}

- (void) activate {
    [super activate];
    [SoundEngine playThatSong:SongTypeMenu];
}

- (void) deactivate {
    [super deactivate];
    [SoundEngine stopThatSong];
}

- (void) loadScores {
    int i = 0;
    int x_os = 120;
    scores = [GameProgress getProgress];
    for(id key in scores){
//        [title setText:[scores objectForKey:key][0]];
        NSLog(@"key=%@ value=%@", key, [scores objectForKey:key]);
        Label* label1 = [self createLabelText:[scores objectForKey:key][0] coord_x:x_os coord_y:120+i] ;
        [scene addItem:label1];
        [label1 setScaleUniform:1.5];
        [label1 setColor:[Color red]];
        label1 = [self createLabelText:[scores objectForKey:key][1] coord_x:x_os + 120 coord_y:120+i] ;
        [scene addItem:label1];
        [label1 setScaleUniform:1.5];
        [label1 setColor:[Color white]];
//        [label2 setScaleUniform:1.125];
//        [label2 setColor:[Color white]];
//        [scene addItem:label1];
//        [scene addItem:label2];
        i += 40;
        if (i == 480){
            i = 0;
            x_os += 200;
        }
    }
}

- (Label*) createLabelText: (NSString*) text coord_x: (int)x coord_y: (int)y {
    NSLog(@"creating label %@ x: %d, y: %d", text, x, y);
    return [[Label alloc] initWithFont:fivexfive text:text position:[Vector2 vectorWithX:x y:y]];
}

- (void) dealloc
{
    //[scores release];
    [title release];
    [super dealloc];
}

@end
