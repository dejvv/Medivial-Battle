//
//  HumanPlayer.m
//  Igra
//
//  Created by David Zagorsek on 12/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import "HumanPlayer.h"
#import "Namespace.Igra.h"


@implementation HumanPlayer

- (id) initWithGame:(Game *)theGame Hero:(Hero *)theHero Level:(Level *)theLevel{
    self = [super initWithGame:theGame];
    if (self != nil) {
        hero = theHero;
        //hero.position = [Vector2 vectorWithX: 640 / 5 y: 1136 / 2 - 50];
        //hero.velocity.x = 0;
        //hero.velocity.y = -50;
        level = theLevel;
        lastTimePressed = 0.0;
        currentTimePressed = 0.0;
        playFootstepSound = NO;
        whichStep = 0;
        attackDuration = 0.0;
        shootFireball = NO;
    }
    return self;
}

- (void) setCamera:(Matrix *)camera {
    [inverseView release];
    inverseView = [[Matrix invert:camera] retain];
}

- (void) updateWithGameTime:(GameTime*)gameTime {
    grabbedLeft = NO;
    grabbedRight = NO;
    shootFireball = NO;
    if(![hero isAlive])
        return;
    //NSLog(@"player: updateWithGameTime");
    if (level.getButtonLeft.isTouched){
        grabbedLeft = YES;
        hero.velocity.x = -hero.speedX;
        //NSLog(@"touch left!");
        [hero setOrientation: @"left"];
        //if (numberOfIterations % 30 == 0)
        playFootstepSound = YES;
    } else if (level.getButtonRight.isTouched) {
        grabbedRight = YES;
        hero.velocity.x = hero.speedX;
        //NSLog(@"touch right!");
        [hero setOrientation: @"right"];
        //if (numberOfIterations % 10 == 0)
        playFootstepSound = YES;
    } else {
        hero.velocity.x = 0;
    }
    
    if (level.getButtonJump.isTouched) {
        if (!hero.getJumped){
            hero.velocity.y = hero.jumpY;
            [hero setJumped:YES];
        }
        
    } else {
        //hero.velocity.y = 0;
    }
    [hero.myWeapon setDetectCollision:NO];
    if (hero.getEnergy >= [Constants getInstance].costEnergySwordAttack && level.getButtonAttack.isTouched) {
        if (fabs(gameTime.totalGameTime - [hero getTimeIntervalSwordAttack]) >= [Constants getInstance].swordAttackDuration){
            [hero setSwordAttack:YES];
            [hero.myWeapon setDetectCollision:YES];
            [hero setTimeIntervalSwordAttack:gameTime.totalGameTime];
            NSLog(@"attack start: %f", attackDuration);
            [hero setEnergy:hero.getEnergy - [Constants getInstance].costEnergySwordAttack * hero.myWeapon.energyPenalty];
            if (hero.getEnergy < 0)
                [hero setEnergy:0];
        }
        
    } else {
        if (hero.getSwordAttack && (fabs(gameTime.totalGameTime - [hero getTimeIntervalSwordAttack]) >= [Constants getInstance].swordAttackDuration)){
            [hero setSwordAttack:NO];
            [hero.myWeapon setDetectCollision:NO];
            NSLog(@"attack end: %f", gameTime.totalGameTime);
        }
    }
    //NSLog(@"player attacking: gametime.elapsed: %f %f", gameTime.totalGameTime, fabs(gameTime.totalGameTime - attackDuration));
    
    if (level.getButtonFire.isTouched) {
        // if hero has enaugh energy he can shot fireball
        if (hero.getEnergy >= [Constants getInstance].costEnergyFireBall &&
            fabs([hero getTimeIntervalFireBallShot] - gameTime.totalGameTime) >= [Constants getInstance].intervalFireBallShot){
            [hero setTimeIntervalFireBallShot:gameTime.totalGameTime];
            shootFireball = YES;
            [hero setEnergy:hero.getEnergy - [Constants getInstance].costEnergyFireBall];
            if (hero.getEnergy < 0)
                [hero setEnergy:0];
        }
    } else {
        shootFireball = NO;
    }
    
    currentTimePressed = gameTime.totalGameTime;
    if (([self isPressedLeft] || [self isPressedRight])) {
        //currentTimePressed = gameTime.totalGameTime;
        //NSLog(@"game time: %f", currentTimePressed - lastTimePressed);
        if (!((currentTimePressed - lastTimePressed) > 0.25)){
            playFootstepSound = NO;
        }
        
    }
    
    if(playFootstepSound && ([self isPressedLeft] || [self isPressedRight])) {
        // play footstep sounds
        lastTimePressed = currentTimePressed;
        if (whichStep == 0) {
            [SoundEngine play:SoundEffectTypePlayerFootstep00];
            whichStep = 1;
        } else {
            [SoundEngine play:SoundEffectTypePlayerFootstep01];
            whichStep = 0;
        }
        
        //NSLog(@"active sound play");
    }
    playFootstepSound = NO;
    //[hero setOrientation: grabbedLeft ? @"left" : (grabbedRight ? @"right" : hero.getOrientation)];
}

- (BOOL) vectorInArea:(Vector2 *)vector rect:(Rectangle *)area{
    return (vector.x >= area.x && vector.x <= area.x + area.width &&
            vector.y >= area.y && vector.y <= area.y + area.height);
}

- (BOOL) isPressedLeft {
    return grabbedLeft;
}

- (BOOL) isPressedRight {
    return grabbedRight;
}

-(BOOL) getShootFireball {
    return shootFireball;
}

- (void) dealloc {
    [inverseView release];
    [hero release];
    [level release];
    [super dealloc];
}

@end
