//
//  FireBall.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import <Foundation/Foundation.h>
#import "Express.Scene.Objects.h"
#import "Namespace.Igra.classes.h"

@interface FireBall : NSObject <IParticle, ICustomCollider, ISceneUser, ICustomUpdate, IMovable, IMass> {
    Vector2 *position;
    Vector2 *velocity;
    float radius;
    float mass;
    id<IScene> scene; // id of scene
    
    NSString *firedBy; // who fired fireball, hero or enemy
    
    int damagePower;
}

@property (nonatomic) int damagePower;

- (void) updateWithGameTime:(GameTime*)gameTime;
- (int) getDamagePower;
- (void) setVelocity:(Vector2 *)velocity;

- (NSString *) getFiredBy;
- (void) setFiredBy: (NSString *) fire;

@end
