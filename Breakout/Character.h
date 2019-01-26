//
//  Character.h
//  MedivialBattle
//
//  Created by David Zagorsek on 18/12/2018.
//

#import <Foundation/Foundation.h>
#import "Namespace.Igra.classes.h"

#import "Express.Physics.h"
#import "Express.Scene.Objects.h"
#import "DGravity.h"

// <IAARectangleCollider, ICustomCollider, IMovable, ISceneUser, ICustomUpdate, DGravity, IMASS>

@interface Character : NSObject<DGravity, IAARectangleCollider, ICustomCollider, IMovable, ISceneUser, ICustomUpdate, IMass> {
    float health; // health
    float energy; // energija
    NSString *orientation; // v katero stran je obrnjen, a gre na levo ali na desno, je uporabno, da veš v katero stran naj leti fireball
    bool jumped; // a je character skočil
    bool swordAttack; // a character napada, mele attack
    NSTimeInterval timeIntervalFireBallShot; // kdaj je bil nazadnje izstreljen fireball, kako pogosto ga lahko izstrelimo je določeno v konstantah
    // timeFireballShot spreminja in opazuje Player, ker Character sam po sebi ne bo izstrelil FireBalla ampak bo (AI)Player to storil
    NSTimeInterval timeIntervalSwordAttack; // kdaj je bil nazadnje izveden sword attack
    // enako kot interval za fireball tudi tale interval lahko spreminja le Player
    
    // spremenljivke, ki nimajo getterja in settera
    NSTimeInterval timeIntervalHealthRegeneration; // kdaj se je helath nazadnje obnovil
    NSTimeInterval timeIntervalEnergyRegeneration; // kdaj se je energija nazadnje obnovila, kako hitro se naj obnvalja je določeno v konstantah
    
    bool blockAttack; // če character blokira attack
    bool blocked; // če je bil attack blokiran, se izgubi nekaj energije
}
@property (nonatomic, readwrite) float speedX; // hitrost premikanja po x-osi
@property (nonatomic, readwrite) float jumpY; // hitrost premikanja oo Y osi oz. skok
@property (nonatomic, retain) ItemSword* myWeapon; // characterjovo orožje tipa ItemSword

- (id) initWithWeapon: (ItemSword*)theSword; // character ve, kateri weapon uporablja, weaponi so swordi

- (bool) isAlive; // vrne true, če je health > 0
- (bool) isMoving; // vrne true, če je abs(velocity.x) > 0
- (float) getHealth; // vrne characterjev health

// getter in setter za energijo
- (float) getEnergy;
- (void) setEnergy: (float) theEnergy;

// getter in setter za orientacijo
- (NSString *) getOrientation;
- (void) setOrientation: (NSString*) theOrientation;

// getter in setter za skok
- (bool) getJumped;
- (void) setJumped: (bool) theJumped;

// getter in setter za sword (mele) attack
- (bool) getSwordAttack;
- (void) setSwordAttack: (bool) isHeroAttacking;

// getter in setter za časovni interval, kdaj je bil fireball sprožen
- (NSTimeInterval) getTimeIntervalFireBallShot;
- (void) setTimeIntervalFireBallShot: (NSTimeInterval) time;

// getter in setter za časovni interval, kdaj je bil sword attack sprožen
- (NSTimeInterval) getTimeIntervalSwordAttack;
- (void) setTimeIntervalSwordAttack: (NSTimeInterval) time;

// metoda izračuna razliko med t1 in t2, če je večja od dif vrne true
// uporabim lahko za računanje različnih intervalov
// primer: če želim, da se energija obnavlja na 1s,
// bo t1 = gameTime.totalTime t2 = timeEnergyRegeneration dif = 1.0;
// v timeEnergyRegeneration shranjujem čas, ko se je energija nazadnje obnovila
// če bo torej razlika med t1 in t2 >= 1.0, bom obnovil energijo
- (bool) doAction:(float)t1 time:(float)t2 difference:(float) dif;

// getter in setter če enemy blokira (naslednji) attack (sword/fireball)
// setter uporablja Player
- (bool) getBlockAttack;
- (void) setBlockAttack: (bool) shouldBlock;

// getter in setter če je bil napad uspešno blokiran
// setter uporablja tisti item, s katerim se je izvedla kolizija (FireBall/itemSword)
- (bool) getBlocked;
- (void) setBlocked: (bool) wasBlocked;

// metoda resetira characterjeve nastavitve, na default, torej health in energijo, pozicijo, regenracijo in ostalo..
- (void) reset;



@end
