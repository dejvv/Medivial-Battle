//
//  SoundEngine.m
//  MedivialBattle
//
//  Created by David Zagorsek on 08/12/2018.
//

#import "SoundEngine.h"

#import "Retronator.Xni.Framework.Content.h"

SoundEngine *instance;
MediaPlayer *player;

@implementation SoundEngine

+ (void) initializeWithGame:(Game*)game {
    instance = [[SoundEngine alloc] initWithGame:game];
    player = [MediaPlayer getInstance]; 
    [game.components addComponent:instance];
}

- (void) initialize {
    soundEffects[SoundEffectTypeFireBallHit] = [self.game.content load:@"FireBallExplosion"];
    soundEffects[SoundEffectTypeFireBallShot] = [self.game.content load:@"FireBallShot"];
    soundEffects[SoundEffectTypePlayerFootstep00] = [self.game.content load:@"footstep00"];
    soundEffects[SoundEffectTypePlayerFootstep01] = [self.game.content load:@"footstep01"];
    
    songs[SongTypeBattle] = [self.game.content load:@"music"];
    songs[SongTypeMenu] = [self.game.content load:@"music_menu"];
}

- (void) play:(SoundEffectType)type {
    //NSLog(@"played on object");
    [soundEffects[type] play];
    activeSound = &type;
}

+ (void) play:(SoundEffectType)type {
    //NSLog(@"played on class");
    [instance play:type];
}

- (SoundEffectType *) getActiveSound {
    return activeSound;
}

// songs
- (void) playThatSong:(SongType)type {
    [player playSong:songs[type]];
}

+ (void) playThatSong:(SongType)type {
    //NSLog(@"i have to play a song: %d", type);
    [instance playThatSong: type];
}

- (void) stopThatSong {
    [player stop];
}

+ (void) stopThatSong {
    [instance stopThatSong];
}

- (void) dealloc
{
    for (int i = 0; i < SoundEffectTypes; i++) {
        [soundEffects[i] release];
    }
    
    for (int i = 0; i < SongTypes; i++) {
        [songs[i] release];
    }
    [super dealloc];
}


@end
