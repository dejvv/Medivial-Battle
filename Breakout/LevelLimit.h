//
//  LevelLimit.h
//  MedivialBattle
//
//  Created by David Zagorsek on 26/11/2018.
//

#import <Foundation/Foundation.h>

#import "Express.Scene.h"
#import "Express.Scene.Objects.h"
#import "Express.Math.h"

#import "Namespace.Igra.classes.h"

@interface LevelLimit : NSObject <IAAHalfPlaneCollider, ICustomCollider, ISceneUser> {
    AAHalfPlane *limit;
    BOOL deadly;
    id<IScene> scene;
}

- (id) initWithLimit:(AAHalfPlane*)theLimit isDeadly:(BOOL)isDeadly;

@end
