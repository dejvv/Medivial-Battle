//
//  HumanPlayer.h
//  Igra
//
//  Created by David Zagorsek on 12/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Namespace.Igra.classes.h"

@interface HumanPlayer : GameComponent {
    Hero *hero;
    BOOL grabbedLeft; // if pressed, sound for steps should be played
    BOOL grabbedRight;
    Matrix *inverseView;
    Level *level;
    BOOL shootFireball; // tells gameplay to add fireball to level.scene, well only if there is no fireballs from player on the scene (level.fireballCount)
    
    BOOL playFootstepSound; // should i play sound
    NSTimeInterval lastTimePressed; // mark last time jump was pressed
    NSTimeInterval currentTimePressed; // mark current time for jump
    int whichStep; // jump which sound to play, 0 or 1
    
    NSTimeInterval attackDuration; // duration of player attack
}

- (id) initWithGame:(Game*)theGame Hero:(Hero*)theHero Level:(Level*) theLevel;
- (void) updateWithGameTime:(GameTime*)gameTime;
- (void) setCamera:(Matrix *) camera;

-(BOOL) vectorInArea:(Vector2*)vector rect:(Rectangle*)area;
-(BOOL) isPressedLeft;
-(BOOL) isPressedRight;
-(BOOL) getShootFireball;

@end

