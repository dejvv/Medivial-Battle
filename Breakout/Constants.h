//
//  Constants.h
//  MedivialBattle
//
//  Created by David Zagorsek on 11/12/2018.
//

#import <Foundation/Foundation.h>


@interface Constants : NSObject {
}

@property (nonatomic, readonly) int groundHeight; // kakšna je višina tal
@property (nonatomic, readonly) float groundY; // kje se nahajajo tla, točna Y koordinata, jo nastavimo s setGround

@property (nonatomic, readonly) float gravityForce; // kakšna je gravitacija

@property (nonatomic, readonly) float swordAttackDuration; // na koliko časa lahko naredimo sword attack

@property (nonatomic, readonly) float costEnergyFireBall; // kolko energije stane fireball
@property (nonatomic, readonly) float costEnergySwordAttack; // kolko energije stane sword attack (mele)
@property (nonatomic, readonly) float intervalFireBallShot; // na koliko časa lahko shootnemo fireball po defaulut
@property (nonatomic, readonly) float defaultFireBallSpeed; // kako hitro potuje fireball po defaultu

@property (nonatomic, readonly) float intervalHealthRegeneration; // na koliko časa se health regenerira po defultu
@property (nonatomic, readonly) float defaultValueHealthRegeneration; // kakšna je regenracija healtha po defaultu
@property (nonatomic, readonly) float defaultValueHealth; // koliko healtha ima igralec po defualtu

@property (nonatomic, readonly) float intervalEnergyRegeneration; // na koliko časa se energija regenerira po defultu
@property (nonatomic, readonly) float defaultValueEnergyRegeneration; // kakšna je regenracija energije po defaultu
@property (nonatomic, readonly) float defaultValueEnergy; // koliko energije ima igralec po defualtu

@property (nonatomic, readonly) float defaultCharacterSpeed; // kako hitro se character premika
@property (nonatomic, readonly) float defaultCharacterJumpHeight; // kako visoko lahko igralec skoči



+ (Constants*) getInstance;
+ (void) setGroundY: (float) cord;

@end
