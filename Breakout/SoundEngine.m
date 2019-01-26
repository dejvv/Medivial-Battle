//
//  SoundEngine.m
//  MedivialBattle
//
//  Created by David Zagorsek on 08/12/2018.
//

#import "SoundEngine.h"

#import "Retronator.Xni.Framework.Content.h"

SoundEngine *instance;

@implementation SoundEngine

+ (void) initializeWithGame:(Game*)game {
    instance = [[SoundEngine alloc] initWithGame:game];
    [game.components addComponent:instance];
}

- (void) initialize {
    soundEffects[SoundEffectTypeFireBallHit] = [self.game.content load:@"FireBallExplosion"];
    soundEffects[SoundEffectTypeFireBallShot] = [self.game.content load:@"FireBallShot"];
    soundEffects[SoundEffectTypePlayerFootstep00] = [self.game.content load:@"footstep00"];
    soundEffects[SoundEffectTypePlayerFootstep01] = [self.game.content load:@"footstep01"];
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

- (void) dealloc
{
    for (int i = 0; i < SoundEffectTypes; i++) {
        [soundEffects[i] release];
    }
    [super dealloc];
}


@end
