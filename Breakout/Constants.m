//
//  Constants.m
//  MedivialBattle
//
//  Created by David Zagorsek on 11/12/2018.
//

#import "Constants.h"

@implementation Constants

static Constants *instance;
static float groundYcord;

+ (void) initialize {
    instance = [[Constants alloc] init];
    groundYcord = 0.0;
}

+ (Constants *) getInstance {
    return instance;
}

+ (void) setGroundY: (float) cord {
    groundYcord = cord;
}

- (int) groundHeight {
    return 156;
}

- (float) groundY {
    return groundYcord;
}


- (float) gravityForce {
    return 9.81;
}

- (float) swordAttackDuration {
    return 0.5;
}

- (float) costEnergyFireBall {
    return 50.0;
}

- (float) costEnergySwordAttack {
    return 10.0;
}

- (float) intervalFireBallShot {
    return 0.5;
}

- (float) defaultFireBallSpeed {
    return 500;
}

- (float) intervalHealthRegeneration {
    return 1.0;
}

- (float) defaultValueHealthRegeneration {
    return 1.2;
}

- (float) defaultValueHealth {
    return 100.0;
}

- (float) intervalEnergyRegeneration {
    return 1.0;
}

- (float) defaultValueEnergyRegeneration {
    return 5.3;
}

- (float) defaultValueEnergy {
    return 200.0;
}

- (float) defaultCharacterSpeed {
    return 300;
}

- (float) defaultCharacterJumpHeight {
    return -600.0;
}


@end
