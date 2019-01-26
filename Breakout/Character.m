//
//  Character.m
//  MedivialBattle
//
//  Created by David Zagorsek on 18/12/2018.
//

#import "Character.h"
#import "Namespace.Igra.h"

@implementation Character

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.position = [[Vector2 alloc] init];
        self.velocity = [[Vector2 alloc] initWithX:0.0 y:0.0];
        mass = 3.0;
        self.userMass = [[Vector2 alloc] initWithVector2:[Vector2 vectorWithX:0 y:mass]];
        timeIntervalHealthRegeneration = 0.0;
        timeIntervalEnergyRegeneration = 0.0;
        timeIntervalFireBallShot = 0.0;
        timeIntervalSwordAttack = 0.0;
        jumped = NO;
        swordAttack = NO;
        width = 72;
        height = 72;
        health = [Constants getInstance].defaultValueHealth;
        energy = [Constants getInstance].defaultValueEnergy;
        blockAttack = NO;
        blocked = NO;
        [self setSpeedX:[Constants getInstance].defaultCharacterSpeed];
        [self setJumpY:[Constants getInstance].defaultCharacterJumpHeight];
    }
    return self;
}

- (id) initWithWeapon: (ItemSword*)theSword
{
    self = [super init];
    if (self != nil) {
        self.position = [[Vector2 alloc] init];
        self.velocity = [[Vector2 alloc] initWithX:0.0 y:0.0];
        mass = 3.0;
        self.userMass = [[Vector2 alloc] initWithVector2:[Vector2 vectorWithX:0 y:mass]];
        timeIntervalHealthRegeneration = 0.0;
        timeIntervalEnergyRegeneration = 0.0;
        timeIntervalFireBallShot = 0.0;
        timeIntervalSwordAttack = 0.0;
        jumped = NO;
        swordAttack = NO;
        width = 72;
        height = 72;
        health = [Constants getInstance].defaultValueHealth;
        energy = [Constants getInstance].defaultValueEnergy;
        blockAttack = NO;
        blocked = NO;
        [self setSpeedX:[Constants getInstance].defaultCharacterSpeed];
        [self setJumpY:[Constants getInstance].defaultCharacterJumpHeight];
        
        myWeapon = theSword;
    }
    return self;
}

@synthesize velocity; // hitrost
@synthesize position; // pozicija
@synthesize height; // višina
@synthesize width; // širina
@synthesize scene; // id scene
@synthesize mass; // navadna masa
@synthesize userMass; // masa za gravitacijo, gre za vektor, ki naj ima vrednost le za y os, če je vrednost 0, se gravitacija ne izvaja
@synthesize speedX; // hitrost premikanja po x-osi
@synthesize jumpY; // hitros premikanja po y-osi oz. hitrost skoka
@synthesize myWeapon; // orožje

- (void)updateWithGameTime:(GameTime *)gameTime {
    // če je character pod groundom nemore skočit, če pa ni, mu pa nastavimo vrednost y za gravitacijski vektor (userMass) na vrednost mase
    // enka je nek offset
    if (position.y + height / 2 + 1 >= [Constants getInstance].groundY) {
        jumped = NO;
        self.velocity.y = 0;
        self.userMass.y = 0.0; // stop calculating gravity
    } else {
        self.userMass.y = mass;
    }
    
    // omeji makimalno hitrost premikanja po x-osi
    if (velocity.x > [Constants getInstance].defaultCharacterSpeed)
        velocity.x = [Constants getInstance].defaultCharacterSpeed;
    
    // obnovi health za characterja
    if ([self doAction:gameTime.totalGameTime time:timeIntervalHealthRegeneration difference:[Constants getInstance].intervalHealthRegeneration]) {
        timeIntervalHealthRegeneration = gameTime.totalGameTime;
        health += [Constants getInstance].defaultValueHealthRegeneration;
        if (health > [Constants getInstance].defaultValueHealth)
            health = [Constants getInstance].defaultValueHealth;
        //NSLog(@"character regenerated health %f", health);
    }
    
    // obnovi energijo za characterja
    if ([self doAction:gameTime.totalGameTime time:timeIntervalEnergyRegeneration difference:[Constants getInstance].intervalEnergyRegeneration]) {
        timeIntervalEnergyRegeneration = gameTime.totalGameTime;
        energy += [Constants getInstance].defaultValueEnergyRegeneration;
        if (energy > [Constants getInstance].defaultValueEnergy)
            energy = [Constants getInstance].defaultValueEnergy;
        //NSLog(@"character regenerated energy %f", energy);
    }
}

- (bool) isAlive {
    return health > 0;
}

- (bool) isMoving {
    return fabs(self.velocity.x) > 0;
}

- (float) getHealth {
    return health;
}

- (float) getEnergy {
    return energy;
}

- (void) setEnergy:(float) theEnergy {
    energy = theEnergy;
}

- (NSString *) getOrientation {
    return orientation;
}

- (void) setOrientation: (NSString*) theOrientation {
    orientation = theOrientation;
}

- (bool) getJumped {
    return jumped;
}

- (void) setJumped: (bool) didHeroJump {
    jumped = didHeroJump;
}

- (bool) getSwordAttack {
    return swordAttack;
}

- (void) setSwordAttack:(bool)isHeroAttacking  {
    swordAttack = isHeroAttacking;
}

- (void) setTimeIntervalFireBallShot:(NSTimeInterval)time {
    timeIntervalFireBallShot = time;
}

- (NSTimeInterval) getTimeIntervalFireBallShot {
    return timeIntervalFireBallShot;
}

- (void) setTimeIntervalSwordAttack:(NSTimeInterval)time {
    timeIntervalSwordAttack = time;
}

- (NSTimeInterval) getTimeIntervalSwordAttack {
    return timeIntervalSwordAttack;
}

- (bool) doAction:(float)t1 time:(float)t2 difference:(float) dif {
    return (fabs(t1 - t2) >= dif);
}

- (bool) getBlockAttack {
    return blockAttack;
}

- (void) setBlockAttack: (bool) shouldBlock {
    blockAttack = shouldBlock;
}

- (bool) getBlocked {
    return blocked;
}

- (void) setBlocked:(bool)wasBlocked {
    blocked = wasBlocked;
}

- (void) reset {
    self.velocity.x = 0;
    self.velocity.y = 0;
    mass = 3.0;
    [self.userMass set:[Vector2 vectorWithX:0 y:mass]];
    timeIntervalHealthRegeneration = 0.0;
    timeIntervalEnergyRegeneration = 0.0;
    timeIntervalFireBallShot = 0.0;
    timeIntervalSwordAttack = 0.0;
    jumped = NO;
    swordAttack = NO;
    width = 72;
    height = 72;
    health = [Constants getInstance].defaultValueHealth;
    energy = [Constants getInstance].defaultValueEnergy;
    blockAttack = NO;
    blocked = NO;
    [self setSpeedX:[Constants getInstance].defaultCharacterSpeed];
    [self setJumpY:[Constants getInstance].defaultCharacterJumpHeight];
}

- (void) dealloc
{
    [myWeapon release];
    [userMass release];
    [scene release];
    [velocity release];
    [position release];
    [super dealloc];
}

@end


