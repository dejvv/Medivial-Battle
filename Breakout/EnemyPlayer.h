//
//  EnemyPlayer.h
//  Igra
//
//  Created by David Zagorsek on 21/11/2018.
//  Copyright © 2018 David Zagorsek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.Igra.classes.h"

@interface EnemyPlayer : GameComponent {
    Enemy *enemy;
    Level *level;
    BOOL shootFireball; // tells gameplay to add fireball to level.scene, well only if there is no fireballs from player on the scene (level.fireballCount)
    NSTimeInterval doAction; // just for test purposes, if enemy player should actually do something
    
    BOOL attackedWithSword; // starts time interval when enemy attacked, to stop animation of attacking
    NSTimeInterval endOfSwordAttack; // when sword attack ended
    
    NSTimeInterval stopBecauseOfFireBallShot; // character should not move into the fireball
}

@property (nonatomic, readwrite, retain) NSString * currentMovementDirection; // v katero smer AI trenutno premika enemya

- (id) initWithGame:(Game *)theGame Enemy:(Enemy*)theEnemy Level:(Level*) theLevel;
- (void) updateWithGameTime:(GameTime*)gameTime;

- (BOOL) getShootFireball;
- (BOOL) shouldJump; // if enemy should jump and avoid fireball
- (BOOL) shouldShootFireBall:(GameTime *) gameTime; // if enemy can shoot fireball
- (BOOL) shouldAttackWithSword: (GameTime *) gameTime; // if enemy should attack with sword
- (NSString *) whereToMove: (GameTime *) gameTime; // where should enemy move next

@end
