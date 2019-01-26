//
//  ItemSword.h
//  MedivialBattle
//
//  Created by David Zagorsek on 12/12/2018.
//

#import <Foundation/Foundation.h>
#import "Namespace.Igra.h"

@interface ItemSword : NSObject <ICustomCollider, IParticle, IRotatable, ISceneUser, ICustomUpdate, IMovable> {
    Character * character; // kateremu characterju pripada item
    int damagePower; // damage
    Matrix * rotation; // transformacijska matrika
    MatrixStruct matrixStruct; // definicja matrike
    
    Vector2 *v1;
    Vector2 *v2;
    Vector2 *v3;
    Vector2 *v4;
}
@property (nonatomic) float energyPenalty; // how much additioanal energy item consumes, multiplier for [Constants].costEnergySwordAttack
@property (nonatomic) bool detectCollision; // collision should be detected only when player is attacking

// vrne kakšen je damage power
- (int) getDamagePower;
// konstruktor, dobi characterja
- (id) initWithCharacter: (Character*)theCharacter;


@end
