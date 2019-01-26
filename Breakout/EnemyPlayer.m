//
//  HumanPlayer.m
//  Igra
//
//  Created by David Zagorsek on 12/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.Igra.h"
#import "HumanPlayer.h"

@implementation EnemyPlayer

- (id) initWithGame:(Game *)theGame Enemy:(Enemy *)theEnemy Level:(Level *)theLevel {
    self = [super initWithGame:theGame];
    if (self != nil) {
        enemy = theEnemy;
        level = theLevel;
        shootFireball = NO;
        doAction = 0;
        //enemy.velocity.x = 200;
        currentMovementDirection = @"right";
        attackedWithSword = NO;
        endOfSwordAttack = 0.0;
    }
    //srandom(time(NULL));
    return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
    shootFireball = NO;
    [enemy.myWeapon setDetectCollision:NO];
    if(![enemy isAlive])
        return;
    
    /*
    // do action every 2s
    if ( fabs(doAction - gameTime.totalGameTime) >= 2.0 ){
        doAction = gameTime.totalGameTime;
        // if enemy has enaugh energy he can shot fireball
        if ([self shouldShootFireBall:gameTime]) {
            shootFireball = YES;
            stopBecauseOfFireBallShot = gameTime.totalGameTime + 0.25;
        } else if ([self shouldAttackWithSword:gameTime]) {
            [enemy setSwordAttack:YES];
            [enemy.myWeapon setDetectCollision:YES];
            //NSLog(@"enemy is attacking with sword, his energy: %f", enemy.getEnergy);
            attackedWithSword = YES;
            // when should enemy attack ends
            endOfSwordAttack = gameTime.totalGameTime + [Constants getInstance].swordAttackDuration;
        } else {
            if (enemy.getSwordAttack){
                [enemy setSwordAttack:NO];
                [enemy.myWeapon setDetectCollision:NO];
            }
        }
        NSLog(@"enemy is attacking with sword: %s, his energy: %f", enemy.getSwordAttack ? "YES" : "NO", enemy.getEnergy);
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
    */
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
        
        [enemy setEnergy:enemy.getEnergy - [Constants getInstance].costEnergyFireBall];
        if (enemy.getEnergy < 0)
            [enemy setEnergy:0];
        
        return YES;
    }
    return NO;
}

-(BOOL) getShootFireball {
    return shootFireball;
}

- (BOOL) shouldAttackWithSword:(GameTime *)gameTime {
    int r = arc4random() % 100;
    
    if(r > 50)
        return NO;
    NSLog(@"random number: %d", r);
    // if character has enaugh energy he can shot fireball
    if (enemy.getEnergy >= [Constants getInstance].costEnergySwordAttack &&
        fabs([enemy getTimeIntervalSwordAttack] - gameTime.totalGameTime) >= [Constants getInstance].swordAttackDuration){
        [enemy setTimeIntervalSwordAttack:gameTime.totalGameTime];
        
        [enemy setEnergy:enemy.getEnergy - [Constants getInstance].costEnergySwordAttack * enemy.myWeapon.energyPenalty];
        if (enemy.getEnergy < 0)
            [enemy setEnergy:0];
        
        return YES;
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
    if (enemy.getSwordAttack || (stopBecauseOfFireBallShot - gameTime.totalGameTime) > 0)
        currentMovementDirection = @"nowhere"; // for standing still
    else if ([currentMovementDirection isEqual:@"nowhere"])
//        currentMovementDirection = arc4random() % 100 > 50 ? @"left" : @"right";
        currentMovementDirection = [enemy getOrientation];
    return currentMovementDirection;
}

@synthesize currentMovementDirection;

- (void) dealloc {
    [enemy release];
    [level release];
    [super dealloc];
}

@end

