//
//  ReflexEnemy.m
//  MedivialBattle
//
//  Created by David Zagorsek on 28/01/2019.
//

#import <Foundation/Foundation.h>
#import "Namespace.Igra.h"
#import "ReflexEnemy.h"

@implementation ReflexEnemy

- (id) initWithGame:(Game *)theGame Enemy:(Enemy *)theEnemy Level:(Level *)theLevel {
    self = [super initWithGame:theGame];
    if (self != nil) {
        enemy = theEnemy;
        level = theLevel;
        shootFireball = NO;
        doAction = 0;
        //enemy.velocity.x = 200;
        currentMovementDirection = @"nowhere";
        attackedWithSword = NO;
        endOfSwordAttack = 0.0;
        
        // stanja
        states = [[NSMutableArray alloc] initWithObjects:@"attackWithSword", @"moveTorwards", @"moveAway", @"shootFireball", @"rest", nil];
        currentState = @"rest";
    }
    //srandom(time(NULL));
    return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
    shootFireball = NO;
    [enemy.myWeapon setDetectCollision:NO];
    if(![enemy isAlive])
        return;
   
    // decide into which state to go
    currentState = [self nextState:gameTime];
   
    
    
     // do action every 2s
     if ( fabs(doAction - gameTime.totalGameTime) >= 0.5 ){
//         NSLog(@"[updateWithGameTime] currentState: %@", currentState);
         
         doAction = gameTime.totalGameTime;
         if ([self shouldAttackWithSword:gameTime]) {
                [enemy setSwordAttack:YES];
                [enemy.myWeapon setDetectCollision:YES];
                //NSLog(@"enemy is attacking with sword, his energy: %f", enemy.getEnergy);
                attackedWithSword = YES;
                // when should enemy attack ends
                endOfSwordAttack = gameTime.totalGameTime + [Constants getInstance].swordAttackDuration;
                // if enemy has enaugh energy he can shot fireball
         } else if ([self shouldShootFireBall:gameTime]) {
                shootFireball = YES;
                stopBecauseOfFireBallShot = gameTime.totalGameTime + 0.25;
         } else {
                if (enemy.getSwordAttack){
                        [enemy setSwordAttack:NO];
                        [enemy.myWeapon setDetectCollision:NO];
                }
         }
//         NSLog(@"enemy is attacking with sword: %s, his energy: %f", enemy.getSwordAttack ? "YES" : "NO", enemy.getEnergy);
     }

     // has enemy attacking eneded yet?
     if (enemy.getSwordAttack)
     // attack has ended
         if((endOfSwordAttack - gameTime.totalGameTime) <= 0){
             [enemy setSwordAttack:NO];
             [enemy.myWeapon setDetectCollision:NO];
         }
     
     
    if ([[self whereToMove:gameTime] isEqual:@"left"]){
        [enemy setOrientation:@"left"];
        enemy.velocity.x = -enemy.speedX;
    } else if ([[self whereToMove:gameTime] isEqual:@"right"]){
        [enemy setOrientation:@"right"];
        enemy.velocity.x = enemy.speedX;
    } else {
        enemy.velocity.x = 0;
    }
    
    if ([self shouldJump]) {
        if (!enemy.getJumped){
            enemy.velocity.y = enemy.jumpY;
            [enemy setJumped:YES];
        }
    }
    
}

- (BOOL) shouldJump {
    for (id item in level.scene) {
        id<IMovable> movable = [item conformsToProtocol:@protocol(ICustomUpdate)] ? item : nil;
        
        if (movable) {
            
            if ([item isKindOfClass:[FireBall class]]) {
                
                if ([[item getFiredBy] isEqual:@"hero"]) {
                    //                    NSLog(@" shouldJump movable fireball fired by: @%@", [item getFiredBy]);
                    //                    NSLog(@"lets see if i should jump %f", enemy.position.x - movable.position.x);
                    if (fabs(enemy.position.x - movable.position.x) <= 150){
                        
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

- (bool) shouldShootFireBall:(GameTime *) gameTime {
    // if character has enaugh energy he can shot fireball
    if (enemy.getEnergy >= [Constants getInstance].costEnergyFireBall &&
        fabs([enemy getTimeIntervalFireBallShot] - gameTime.totalGameTime) >= [Constants getInstance].intervalFireBallShot){
        [enemy setTimeIntervalFireBallShot:gameTime.totalGameTime];
        
        if ([currentState isEqual:@"shootFireball"]){
            [enemy setEnergy:enemy.getEnergy - [Constants getInstance].costEnergyFireBall];
            if (enemy.getEnergy < 0)
                [enemy setEnergy:0];
            
            return YES;
        }
    }
    return NO;
}

-(BOOL) getShootFireball {
    return shootFireball;
}

- (BOOL) shouldAttackWithSword:(GameTime *)gameTime {
    // if character has enaugh energy he can shot fireball
    if (enemy.getEnergy >= [Constants getInstance].costEnergySwordAttack &&
        fabs([enemy getTimeIntervalSwordAttack] - gameTime.totalGameTime) >= [Constants getInstance].swordAttackDuration){
        [enemy setTimeIntervalSwordAttack:gameTime.totalGameTime];
        
        if ([currentState isEqual:@"attack"]){
            [enemy setEnergy:enemy.getEnergy - [Constants getInstance].costEnergySwordAttack * enemy.myWeapon.energyPenalty];
            if (enemy.getEnergy < 0)
                [enemy setEnergy:0];
            
            return YES;
        }
    }
    return NO;
}

- (NSString*) whereToMove: (GameTime *) gameTime {
    //    NSLog(@"[whereToMove] enemy pos: %.2f, %.2f and gamebounds: %.2f, %.2f", enemy.position.x, enemy.position.y, (float)level.game.gameWindow.clientBounds.x, (float)level.game.gameWindow.clientBounds.width);
    if (enemy.position.x >= (float)level.game.gameWindow.clientBounds.width) {
        currentMovementDirection = @"left";
    } else if (enemy.position.x - enemy.width / 2 <= (float)level.game.gameWindow.clientBounds.x){
        currentMovementDirection = @"right";
    }
    //NSLog(@"[whereTomove] enemy attacking %s", enemy.getSwordAttack ? "YES" : "NO");
    // if enemy is currently attacking he can not move
    else if (enemy.getSwordAttack || (stopBecauseOfFireBallShot - gameTime.totalGameTime) > 0)
        currentMovementDirection = @"nowhere"; // for standing still
    else if ([currentState isEqual:@"moveTorwards"]){
        Vector2 *difference = [Vector2 subtract:enemy.position by:level.hero.position];
        float distance = [difference length];
//        NSLog(@"[whereToMove] distance between enemy and hero: %f and difference.x: %f", distance, difference.x);
        if (distance > 70) {
            if (difference.x < 0)
                currentMovementDirection = @"right";
            else if (difference.x > 0) {
                currentMovementDirection = @"left";
            }
//            NSLog(@" move torwards hero");
        } else {
            currentMovementDirection = @"nowhere";
        }
    } else if ([currentState isEqual:@"moveAway"]){
        Vector2 *difference = [Vector2 subtract:enemy.position by:level.hero.position];
        float distance = [difference length];
        //        NSLog(@"[whereToMove] distance between enemy and hero: %f and difference.x: %f", distance, difference.x);
        if (distance < 300) {
            if (difference.x < 0)
                currentMovementDirection = @"left";
            else if (difference.x > 0) {
                currentMovementDirection = @"right";
            }
            //            NSLog(@" move torwards hero");
        } else {
            currentMovementDirection = @"nowhere";
        }
    }
    return currentMovementDirection;
}

- (NSString* ) nextState:(GameTime* )gameTime {
    NSString *woot = @"rest";
    if ([self moveTorwards:gameTime])
        woot = @"moveTorwards";
    else if ([self shootFireBallState:gameTime]){
        woot = @"shootFireball";
    }
    else if ([self attackWithSword:gameTime]){
        woot = @"attack";
    }
    else if ([self moveAway:gameTime]){
        woot = @"moveAway";
    }
    
    
    // let hero rest
    return woot;
}

- (BOOL) moveTorwards:(GameTime*) gameTime {
//    NSLog(@"[moveTorwards] hero energy: %f", level.hero.getEnergy);
    if ((timeInState - gameTime.totalGameTime) > 0)
        return NO;
    Vector2 *difference = [Vector2 subtract:enemy.position by:level.hero.position];
    float distance = [difference length];
    if (distance < 72)
        return NO;
//    if (level.hero.getEnergy < enemy.getEnergy || level.hero.getHealth < enemy.getHealth)
    if (![currentState isEqual:@"moveAway"] && ![self isDanger])
        return YES;
    return NO;
    // criteria not met
//    return NO;
}

- (BOOL) attackWithSword:(GameTime*)gameTime {
    Vector2 *difference = [Vector2 subtract:enemy.position by:level.hero.position];
    float distance = [difference length];
    if ([self isDanger])
        return NO;
    if ([currentState isEqual:@"moveAway"])
        return NO;
    if (distance < 72)
        [enemy setOrientation: difference.x > 0 ? @"left" : @"right"];
        return YES;
    return NO;
}

- (BOOL) moveAway:(GameTime*)gameTime {
//    NSLog(@"[moveTorwards] hero energy: %f", level.hero.getEnergy);
    if ([currentState isEqual:@"moveAway"] && (timeInState - gameTime.totalGameTime) > 0)
        return YES;
    if ([self isDanger]){
        timeInState = gameTime.totalGameTime + 3.0;
        return YES;
    }
    // criteria not met
    return NO;
}

- (BOOL) shootFireBallState:(GameTime*)gameTime {
    Vector2 *difference = [Vector2 subtract:enemy.position by:level.hero.position];
    float distance = [difference length];
    //NSLog(@"fireball distance: %f", distance);
    if (distance > 250){
        [enemy setOrientation: difference.x > 0 ? @"left" : @"right"];
        return YES;
    }
    
    return NO;
}

- (BOOL) isDanger {
    int health = enemy.getHealth + 40 - level.hero.getHealth;
    int energy = enemy.getEnergy + 50 - level.hero.getEnergy;
    //NSLog(@"health-energy: %d", health-energy);
    
    return (enemy.getHealth <= 30) || ((health < 0) && (energy < 0));
}

@synthesize currentMovementDirection;

- (void) dealloc {
    //[enemy release];
    //[level release];
    [super dealloc];
}

@end
