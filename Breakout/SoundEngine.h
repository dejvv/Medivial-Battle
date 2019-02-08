//
//  SoundEngine.h
//  MedivialBattle
//
//  Created by David Zagorsek on 08/12/2018.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Audio.h"
#import "Retronator.Xni.Framework.Media.h"
#import "Namespace.Igra.classes.h"

@interface SoundEngine : GameComponent {
    SoundEffect *soundEffects[SoundEffectTypes];
    SoundEffectType *activeSound;
    
    //songs
    Song *songs[SongTypes];
}

+ (void) initializeWithGame:(Game*)game;
+ (void) play:(SoundEffectType)type;
- (SoundEffectType *) getActiveSound;

// songs
+ (void) playThatSong:(SongType)type;
+ (void) stopThatSong;

@end
